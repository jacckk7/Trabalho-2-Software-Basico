-> Compilar o programa
>> nasm -f elf -o calculadora.o calculadora.asm && nasm -f elf -o soma.o soma.asm && nasm -f elf -o subtracao.o subtracao.asm && nasm -f elf -o multiplicacao.o multiplicacao.asm && nasm -f elf -o divisao.o divisao.asm && nasm -f elf -o exponenciacao.o exponenciacao.asm && nasm -f elf -o mod.o mod.asm

>> ld -m elf_i386 -o calculadora calculadora.o soma.o subtracao.o multiplicacao.o divisao.o exponenciacao.o mod.o

-> Configurar git no wsl
>> git config --global user.email "you@example.com"
>> git config --global user.name "Your Name"

-> Pegar repositório
>> git init
>> git branch -m main
>> git remote add origin https://github.com/jacckk7/Trabalho-2-Software-Basico.git
>> git pull

-> Fazer commit
>> git checkout -b <nome da branch>
>> git add .
>> git commit -m "<Mensagem do que foi alterado>"
>> git push origin <nome da branch>

-> Após pr feito
>> git checkout main
>> git pull