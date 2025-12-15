BEGIN {
    print "Aluno: Situação: Média"
}

{
    if (NR > 1) {
        media = ($2 + $3 + $4) / 3

        if (media >= 7.0) {
            situacao = "Aprovado" 
        } else if (media >= 5.0) {
            situacao = "Final"    
        } else {
            situacao = "Reprovado" 
        }

        soma1 += $2
        soma2 += $3
        soma3 += $4

        printf "%s: %s: %.1f\n", $1, situacao, media
    }
}

END {
    qtd_alunos = NR - 1
    if (qtd_alunos > 0) {
        media1 = soma1 / qtd_alunos
        media2 = soma2 / qtd_alunos
        media3 = soma3 / qtd_alunos
        print "Média por prova:", media1, media2, media3
    }
}
