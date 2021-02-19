-- Prototype of RealizedAttributes as described in
-- https://blog.singularitynet.io/ai-dsl-toward-a-general-purpose-description-language-for-ai-agents-21459f691b9e

module RealizedAttributes

public export
CostT : Type
CostT = Double

public export
record Costs where
  constructor MkCosts
  financial, temporal, computational : CostT

public export
QualityT : Type
QualityT = Double

public export
record RealizedAttributes where
  constructor MkRealizedAttributes
  costs : Costs
  quality : QualityT

-- Add costs
public export
add_costs : Costs -> Costs -> Costs
add_costs x y = MkCosts (x.financial + y.financial)
                        (x.temporal + y.temporal)
                        (x.computational + y.computational)

-- Add costs, minimum quality
public export
add_costs_min_quality : RealizedAttributes -> RealizedAttributes -> RealizedAttributes
add_costs_min_quality f_attrs g_attrs = fg_attrs where
  fg_attrs : RealizedAttributes
  fg_attrs = MkRealizedAttributes (add_costs f_attrs.costs g_attrs.costs)
                                  (min f_attrs.quality g_attrs.quality)
