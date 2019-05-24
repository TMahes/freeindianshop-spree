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
          var filtered3=filtered2.filter(function(item){
            return item.parent_id!="6";         
            });
          var filtered4=filtered3.filter(function(item){
            return item.parent_id!="84";         
            });
          var filtered5=filtered4.filter(function(item){
            return item.parent_id!="227";         
            });
          var filtered6=filtered5.filter(function(item){
            return item.parent_id!="299";         
            });
          var filtered7=filtered6.filter(function(item){
            return item.parent_id!="148";         
            });
          var filtered8=filtered7.filter(function(item){
            return item.parent_id!="83";         
            });
          var filtered9=filtered8.filter(function(item){
            return item.parent_id!="226";         
            });
          var filtered10=filtered9.filter(function(item){
            return item.parent_id!="298";         
            });
          var filtered11=filtered10.filter(function(item){
            return item.parent_id!="6";         
            });
          var filtered12=filtered11.filter(function(item){
            return item.parent_id!="373";         
            });
          var filtered13=filtered12.filter(function(item){
            return item.parent_id!="45";         
            });
          var filtered14=filtered13.filter(function(item){
            return item.parent_id!="271";         
            });
          var filtered15=filtered14.filter(function(item){
            return item.parent_id!="180";         
            });
          var filtered16=filtered15.filter(function(item){
            return item.parent_id!="83";         
            });
          var filtered17=filtered16.filter(function(item){
            return item.parent_id!="406";         
            });

          return {
            results: filtered17,
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
