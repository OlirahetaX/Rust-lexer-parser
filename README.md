### 1. Clonar repositorio
git clone https://github.com/OlirahetaX/Rust-lexer-parser

### 2. Entrar a la carpeta del proyecto
cd Rust-lexer-parser/

### 3. Compilar el proyecto
gcc parser.tab.c lex.yy.c -o rust_parser

*** Esto crear un ejercutable rust_parser.exe ***

### 4. Ejecutar programa
./rust_parser.exe < input.txt

*** Aqui le pasamos al ejecutable el archivo donde tenemos un ejemplo de codigo Rust ***

