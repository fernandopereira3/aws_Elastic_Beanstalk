module "producao" {
    source    = "../../devop"
    nome      = "producao"
    max       = 5
    instancia = "t2.micro"
}