class AbilityDecorator
  include CanCan::Ability
  def initialize(user)
    #can [:read, :index], Spree::NewsEntry


    if user.respond_to?(:has_spree_role?) && user.has_spree_role?('Sellers')
      can :choose, Spree::Product
      can [:admin, :manage], Spree::Product
      can [:admin, :manage], Spree::Image
      can [:read], Spree::Taxonomy
      can [:admin, :manage], Spree::Variant
      can [:index, :manage], Spree::OptionType
      can [:admin, :index, :manage], Spree::OptionValue, supplier_id: user.supplier_id
    end
  end
end


Spree::Ability.register_ability(AbilityDecorator)