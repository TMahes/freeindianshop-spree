def applicable_filters
  fs = []
  # fs << ProductFilters.taxons_below(self)
  ## unless it's a root taxon? left open for demo purposes

  fs << Spree::Core::ProductFilters.price_filter if Spree::Core::ProductFilters.respond_to?(:price_filter)
  fs << Spree::Core::ProductFilters.brand_filter if Spree::Core::ProductFilters.respond_to?(:brand_filter)
  fs << Spree::Core::ProductFilters.colour_filter if Spree::Core::ProductFilters.respond_to?(:colour_filter)
  fs
end