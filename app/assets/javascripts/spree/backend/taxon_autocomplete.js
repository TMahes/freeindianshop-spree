'use strict';

var set_taxon_select = function(selector){
  function formatTaxon(taxon) {
    return Select2.util.escapeMarkup(taxon.pretty_name);
  }

  if ($(selector).length > 0) {
    $(selector).select2({
      placeholder: Spree.translations.taxon_placeholder,
      multiple:true,
      initSelection: function (element, callback) {
        var url = Spree.url(Spree.routes.taxons_api, {
          ids: element.val(),
          without_children: false,
          token: Spree.api_key
        });
        return $.getJSON(url, null, function (data) {
          return callback(data['taxons']);
        });
      },
      ajax: {
        url: Spree.routes.taxons_api,
        datatype: 'json',
        data: function (term, page) {
          return {
            per_page: 50,
            page: page,
            without_children: false,
            q: {
              name_cont: term
            },
            token: Spree.api_key
          };
        },
        results: function (data, page) {
          var more = page < data.pages;
          var filtered=data['taxons'].filter(function(item){
            return item.parent_id!="1";         
            });
          var filtered2=filtered.filter(function(item){
            return item.parent_id!="2";         
            });
          return {
            results: filtered2,
            more: more
          };
        }
      },
      formatResult: formatTaxon,
      formatSelection: formatTaxon
    });
  }
}

$(document).ready(function () {
  set_taxon_select('.product_taxon_ids')
});
