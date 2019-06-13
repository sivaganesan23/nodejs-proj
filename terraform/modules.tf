module "network" {
    source          = "./Modules/network"
    proj            = "${var.proj}"
    application     = "${var.application}"
}

module "infra" {
    source          = "./Modules/infra"
    public_subnets  = "${module.network.public_subnets}"
    proj            = "${var.proj}"
    application     = "${var.application}"
    vpcid           = "${module.network.vpcid}"
}
