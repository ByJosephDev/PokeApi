//
//  ViewController.swift
//  ProjectMVVM
//
//  Created by Linder Anderson Hassinger Solano    on 22/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let pokeViewModel: PokeViewModel = PokeViewModel()
    
    var filterData : [Result] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Task{
            await setUpData()
            setUpView()
        }
        
    }
    
    func setUpData() async {
        
        await pokeViewModel.getDataFromAPI()
        filterData = pokeViewModel.pokemones
        tableView.reloadData()
        
    }
    
    func setUpView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let pokemon = filterData[indexPath.row]
        
        cell.textLabel?.text = pokemon.name.capitalized
        cell.imageView?.image = HelperImage.setImage(id: HelperString.getIdFromUrl(url: filterData[indexPath.row].url))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(filterData[indexPath.row].name)
        
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = searchText.isEmpty
        ? pokeViewModel.pokemones
        : pokeViewModel.pokemones.filter({(pokemon : Result) -> Bool in
                                           return pokemon.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            
        })
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}
