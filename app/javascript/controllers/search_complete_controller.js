import { Controller } from "@hotwired/stimulus"
import autocomplete from 'js-autocomplete';

// Connects to data-controller="search-complete"
export default class extends Controller {
  static targets = ["query"]
  static values = { source: String }

  connect() {
    const source = JSON.parse(this.sourceValue)
    const searchInput = this.queryTarget;

    if (source && searchInput) {
      new autocomplete({
        selector: searchInput,
        minChars: 1,
        source: function(term, suggest){
            term = term.toLowerCase();
            const choices = source;
            const matches = [];
            for (let i = 0; i < choices.length; i++)
                if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);
            suggest(matches);
        },
      });
    }
  };
}
