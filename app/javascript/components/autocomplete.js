import autocomplete from 'js-autocomplete';

const autocompleteSearch = function() {
  const source = JSON.parse(document.getElementById('search-data').dataset.source)
  const searchInput = document.getElementById('query');

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

export { autocompleteSearch };
