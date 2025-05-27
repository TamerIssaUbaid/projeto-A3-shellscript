#!/bin/bash

# Projeto A3 - Menu de Sistema em Shell Script
# Grupo:  Támer Issa Ubaid / Felipe Menegazzi / Enyinna Elvis Ugwu / Fabrício Sales Falchet / Carlos Eduardo Basilio Vieira dos Santos / 
# Marcos Henrique Pereira Nunes  / Poliana Matos
# Data: 25/05/2025

while true; do
    clear
    echo "========= MENU PRINCIPAL ========="
    echo "1. Contar arquivos com string no nome"
    echo "2. Cadastrar novo usuário"
    echo "3. Buscar usuários por string"
    echo "4. Buscar grupos por string"
    echo "5. Verificar IP na rede"
    echo "6. Exibir informações do sistema"
    echo "7. Detalhes de um arquivo"
    echo "8. Total de usuários e grupos"
    echo "9. Funcionalidade livre 1"
    echo "10. Funcionalidade livre 2"
    echo "11. Sair"
    echo "=================================="
    read -p "Escolha uma opção: " opcao

    case $opcao in
        1)
            read -p "Digite o caminho do diretório: " dir
            read -p "Digite a string a buscar: " str
            if [ -d "$dir" ]; then
                count=$(find "$dir" -type f -name "*$str*" | wc -l)
                echo "Arquivos encontrados: $count"
            else
                echo "Diretório inválido."
            fi
            read -p "Pressione <Enter> para continuar...";;

        2)
            read -p "Digite o nome do novo usuário: " usuario
            if id "$usuario" &>/dev/null; then
                echo "Usuário já existe."
            else
                sudo useradd "$usuario" && echo "Usuário $usuario criado com sucesso."
            fi
            read -p "Pressione <Enter> para continuar...";;

        3)
            read -p "Digite a string para buscar em logins: " str
            count=$(cut -d: -f1 /etc/passwd | grep "$str" | wc -l)
            echo "Usuários encontrados: $count"
            read -p "Pressione <Enter> para continuar...";;

        4)
            read -p "Digite a string para buscar em grupos: " str
            count=$(cut -d: -f1 /etc/group | grep "$str" | wc -l)
            echo "Grupos encontrados: $count"
            read -p "Pressione <Enter> para continuar...";;

        5)
            read -p "Digite o IP para verificar: " ip
            ping -c 1 "$ip" &>/dev/null && echo "IP ativo." || echo "IP inativo."
            read -p "Pressione <Enter> para continuar...";;

        6)
            echo "Memória RAM livre:"
            free -h | grep Mem | awk '{print $4 " livres"}'
            echo "CPU:"
            lscpu | grep "Model name" | sed 's/Model name:[ \t]*//'
            echo "Espaço em disco disponível:"
            df -h / | tail -1 | awk '{print $4 " livres"}'
            read -p "Pressione <Enter> para continuar...";;

        7)
            read -p "Digite o caminho completo do arquivo: " arq
            if [ -f "$arq" ]; then
                ls -lh "$arq"
            else
                echo "Arquivo não encontrado."
            fi
            read -p "Pressione <Enter> para continuar...";;

        8)
            u_total=$(cut -d: -f1 /etc/passwd | wc -l)
            g_total=$(cut -d: -f1 /etc/group | wc -l)
            echo "Total de usuários: $u_total"
            echo "Total de grupos: $g_total"
            read -p "Pressione <Enter> para continuar...";;

        9)
            echo "Funcionalidade livre 1: Exibir processos ativos do usuário atual"
            ps -u $USER
            read -p "Pressione <Enter> para continuar...";;

        10)
            echo "Funcionalidade livre 2: Verificar atualizações do sistema (Debian/Ubuntu)"
            sudo apt update
            read -p "Pressione <Enter> para continuar...";;

        11)
            echo "Saindo do sistema. Até mais!"
            break;;

        *)
            echo "Opção inválida. Tente novamente."
            read -p "Pressione Enter para continuar...";;
    esac

done
