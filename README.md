# ISG-TEST

# Objetivo
Este projeto é uma pequena Api para criar usuários, postagens e comentários. Onde para criar as postagens é necessário ter um usuário logado, porém é livre para comentar sem um usuário.

## Iniciando o projeto
Este projeto foi realizado utilizando Ruby `3.3.0` com Rails `7.1.3.2`. Utilizei o `asdf` como gerenciador de versões, particularmente gosto pois centraliza minha stack em um único lugar.

Primeiro vamos realizar as instalações, 
### Instalação `asdf`
> :warning: **AVISO:** Não é necessário para rodar o projeto, pode utilizar os gerenciadores de preferência, se não utilizar o `asdf` desconsidere, se já tiver com as dependências do Ruby `3.3.0` e Rails `7.1.3.2` vá para 

1. Atualize os pacotes do seu sistema:
```sudo apt update```
2. Atualize os pacotes do seu sistema:
```sudo apt install curl git```
3. Clone o repositório ASDF do GitHub:
```git clone https://github.com/asdf-vm/asdf.git ~/.asdf```
4. Adicione o ASDF ao seu bash, eu utilizo `zshrc` com plugins para `asdf`:
   https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/asdf
   Adicione o seguinte ao `~/.zshrc` `plugins=(asdf)`
5. Abra um novo terminal ou execute `source ~/.bashrc` para aplicar as alterações.

### Instalação do `Ruby` pelo `asdf`
1. Adicione o plugin Ruby ao ASDF: https://github.com/asdf-vm/asdf-ruby    
   ```asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git```
2. Instale a versão 3.3.0: `asdf install ruby 3.3.0`
3. Defina a versão instalada do Ruby como a versão global padrão: `asdf global ruby 3.3.0`

### Instalação do `Rails`
1. Instale a gem Rails na versão `7.1.3.2`: `gem install rails -v 7.1.3.2`
2. Verifique a instalação do Rails: `Rails -v`          
   Você deve ver `Rails 7.1.3.2`

### Iniciando projeto
1. Clonando o repositório: `git clone git@github.com:vbrenodev/isg-test.git`
2. Instale as dependências com o `bundle install` ou `bundle` apenas.
3. Gere uma secret key para a variável de ambiente `JWT_SECRET_KEY`: `rails secret`
4. Defina nas variáveis de ambiente utilizando `.env`, disponibilizei um `.env.example`
5. Agora é ser feliz utilizando `rails s`

### Executar tests
Após realizar todas as configurações e iniciar uma vez o projeto utilize para os testes
`bundle exec rspec`


# Features
<!--ts-->
  * [x] User
    * [x] Login
      * [x] Tests
    * [x] Registrations
      * [x] Tests
  * [x] Post
    * [x] Create
      * [x] Tests
    * [x] Read
      * [x] Tests
    * [x] Update
      * [x] Tests
    * [x] Delete
      * [x] Tests
  * [x] Comment
    * [x] Create
      * [x] Tests
    * [x] Read
      * [x] Tests
    * [x] Update
      * [x] Tests
    * [x] Delete
      * [x] Tests

  * [x] Readme Doc
<!--te-->
