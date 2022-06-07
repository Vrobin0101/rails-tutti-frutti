import { Controller } from "@hotwired/stimulus"
import autocomplete from 'js-autocomplete';

// Connects to data-controller="search-users"
export default class extends Controller {
  connect() {
    const users = JSON.parse(document.getElementById('search-data').dataset.users)
    const searchInput = document.getElementById('q');

    if (users && searchInput) {
      new autocomplete({
        selector: searchInput,
        minChars: 1,
        source: function(term, suggest){
            term = term.toLowerCase();
            const choices = users;
            const matches = [];
            for (let i = 0; i < choices.length; i++)
                if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);
            suggest(matches);
            console.log(matches)
        },
      });
    }
  }
}
