class AbilityDecorator
  include CanCan::Ability
  def initialize(user)
    #can [:read, :index], Spree::NewsEntry


    if user.respond_to?(:has_spree_role?) && user.has_spree_role?('Sellers')
      can :choose, Spree::Product
      can [:admin, :manage], Spree::Product
      can [:admin, :manage], Spree::Image
      can [:admin, :manage], Spree::Taxon
      can [:manage], Spree::Taxonomy
      can [:admin, :index, :read, :update], Spree::Variant
      can [:admin, :index, :manage], Spree::OptionType
      can [:manage], :taxons
    end
  end
end


Spree::Ability.register_ability(AbilityDecorator)