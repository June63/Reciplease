//
//  RecipesListViewController.swift
//  Reciplease
//
//  Created by Léa Kieffer on 23/12/2021.
//

import UIKit

enum State {
    case loading
    case error
    case empty
    case showingData
}

// MARK: - Enum RecipeListeMode

enum RecipeListMode {
    case api
    case database
    
    var title: String {
        switch self {
        case .api:
            return "Search"
        case .database:
            return "Favorites"
        }
    }
    
    var emptyViewTitle: String {
        switch self {
        case .api:
            return "Sorry no recipes were found"
        case .database:
            return "You have no favorites"
        }
    }

    var emptyViewSubtitle: String {
        switch self {
        case .api:
            return "Please try with different ingredients"
        case .database:
            return "Use the search feature to add favorites"
        }
    }
}

class RecipesListViewController: UIViewController {
    
    // MARK: - Properties
    
    var recipeMode: RecipeListMode
    var ingredients: String = ""
    var recipe: Recipe?

    var viewState: State = .loading {
        didSet {
            resetViewState()
            
            switch viewState {
            case .loading:
                loadingIndicator.startAnimating()
            case .error:
                errorView.isHidden = false
            case .empty:
                emptyView.isHidden = false
            case .showingData:
                tableView.isHidden = false
                tableView.reloadData()
            }
        }
    }

    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let errorView = StateView()
    private let emptyView = StateView()
    private let tableView = UITableView()
    private var recipes: [Recipe] = []
    
    // MARK: - Init
    
    init(recipeMode: RecipeListMode) {
        self.recipeMode = recipeMode
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.recipeMode = .database
        super.init(coder: coder)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getRecipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if recipeMode == .database {
            getRecipesFromDatabase()
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        title = recipeMode.title
        navigationItem.rightBarButtonItem = (recipeMode == .database) ? editButtonItem : nil
        
        view.backgroundColor = UIColor(named: "brown")
        
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(RecipeCell.self, forCellReuseIdentifier: Constants.Storyboard.recipeCellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)

        emptyView.image = #imageLiteral(resourceName: "kitchenOne")
        emptyView.title = recipeMode.emptyViewTitle
        emptyView.subtitle = recipeMode.emptyViewSubtitle
        emptyView.isHidden = true
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyView)
 
        errorView.image = #imageLiteral(resourceName: "kitchenOne")
        errorView.title = "Something went wrong"
        errorView.subtitle = "We're sorry, please try again"
        errorView.isHidden = true
        errorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - private function
    
    private func getRecipes() {
        switch recipeMode {
        case .api:
            getRecipesFromApi()
        case .database:
            getRecipesFromDatabase()
        }
    }
    
    private func getRecipesFromApi() {
        viewState = .loading
        NetworkServiceRecipe.shared.getRecipes(ingredients: ingredients) { [weak self] result in
            switch result {
            case .success(let reciplease) where reciplease.recipes.isEmpty:
                print("no recipes found")
                self?.viewState = .empty
            case .success(let reciplease):
                self?.recipes = reciplease.recipes
                self?.viewState = .showingData
            case .failure(let error):
                print("Error fetching recipes from api: \(error.localizedDescription)")
                self?.viewState = .error
            }
        }
    }
    
    private func getRecipesFromDatabase() {
        do {
            recipes = try DatabaseService.shared.loadRecipes()
            if recipes.isEmpty {
                print("no favorites recipes found")
                viewState = .empty
            } else {
                viewState = .showingData
            }
        } catch let error {
            print("Error fetching recipes from database: \(error.localizedDescription)")
            viewState = .error
        }
    }
    
    private func resetViewState() {
        errorView.isHidden = true
        emptyView.isHidden = true
        tableView.isHidden = true
        loadingIndicator.stopAnimating()
    }
}

// MARK: - Table View delegate

extension RecipesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Constants.Storyboard.main, bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.detailView) as? DetailViewController else { return }
        detailVC.recipe = recipes[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard recipeMode == .database else { return nil }
        
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "Delete") { (action, view, completionHandler) in
                let recipeToDelete = self.recipes[indexPath.row]
                do {
                    try DatabaseService.shared.delete(recipe: recipeToDelete)
                    DispatchQueue.main.async {
                        self.getRecipesFromDatabase()
                    }
                    completionHandler(true)
                } catch let error {
                    print("Error deleting recipe: \(error.localizedDescription)")
                    completionHandler(false)
                    self.displayAlert(title: "Database Core Data error", message: "Cannot be download favorite recipe")
                }
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - Table View datasource

extension RecipesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.recipeCellId, for: indexPath) as! RecipeCell
        cell.recipe = recipes[indexPath.row]
        return cell
    }
}

