# Set common variables for the region. This is automatically pulled in in the root terragrunt.hcl configuration to
# configure the remote state bucket and pass forward to the child modules as inputs.
locals {
  location = "westus3"
}

# allowable locations:
# "australiacentral,australiacentral2,australiaeast,australiasoutheast,brazilsouth,brazilsoutheast,brazilus,canadacentral,canadaeast,centralindia,centralus,centraluseuap,eastasia,eastus,eastus2,eastus2euap,francecentral,francesouth,germanynorth,germanywestcentral,israelcentral,italynorth,japaneast,japanwest,jioindiacentral,jioindiawest,koreacentral,koreasouth,malaysiasouth,mexicocentral,northcentralus,northeurope,norwayeast,norwaywest,polandcentral,qatarcentral,southafricanorth,southafricawest,southcentralus,southeastasia,southindia,spaincentral,swedencentral,swedensouth,switzerlandnorth,switzerlandwest,uaecentral,uaenorth,uksouth,ukwest,westcentralus,westeurope,westindia,westus,westus2,westus3,austriaeast,centralusfoundational,chilecentral,eastusslv,indonesiacentral,israelnorthwest,malaysiawest,newzealandnorth,westeuropefoundational"