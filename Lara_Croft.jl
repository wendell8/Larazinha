# Importação de bibi
    using DelimitedFiles
    using Plots
 
 # Declarar variáveis
    linha = 0
    coluna = 0

 # Ler o arquivo os 'Linhas.dat'e 'Colunas.dat' e contar o número de linhas
    linhas_file = open("Linhas.dat", "r")
    while !eof(linhas_file)
        global linha += 1
        readline(linhas_file)
    end
    close(linhas_file)

    colunas_file = open("Colunas.dat", "r")
    while !eof(colunas_file)
        global coluna += 1
        readline(colunas_file)
    end
    close(colunas_file)

#######################################################
# Alocar memória para os vetores e matriz (NÃO É OBRIGATÓRIO)
    Linhas = Vector{Int}(undef, linha)
    Colunas = Vector{Int}(undef, coluna)
    image = Array{Int}(undef, linha, coluna)
    image_final = Array{Int}(undef, linha, coluna)

#######################################################
# Ler o arquivo 'Lara_Croft.dat' e armazenar os valores na matriz 'image'
    lara_croft_file = open("Lara_Croft.dat", "r")
    for i in 1:linha
        image[i, :] = readline(lara_croft_file) |> x -> parse.(Int, split(x))
    end
    close(lara_croft_file)

#######################################################
# Ler os arquivos 'Linhas.dat' e 'Coluna.dat' novamente e armazenar os valores no vetor 'Linhas' e 'Colunas'
    linhas_file = open("Linhas.dat", "r")
    for i in 1:linha
        Linhas[i] = parse(Int, readline(linhas_file))
    end
    close(linhas_file)
    #////////////////////////////////////////////////////
    colunas_file = open("Colunas.dat", "r")
    for j in 1:coluna
        Colunas[j] = parse(Int, readline(colunas_file))
    end
    close(colunas_file)

#######################################################
 # Colocar as linhas e colunas em seus devidos lugares
    for j in 1:coluna
        for i in 1:linha
            image_final[i, j] = image[Linhas[i], Colunas[j]]
        end
    end

#######################################################
# Escrever a imagem corrigida no arquivo 'Imagem_corrigida.dat'
imagem_corrigida_file = open("Imagem_corrigida.dat", "w")
for i in 1:linha
    println(imagem_corrigida_file, join(image_final[i, :], "\t"))
end
close(imagem_corrigida_file)

println("A imagem está pronta para plotagem!")

#######################################################
# Plotar a imgem com a matriz corrigida
LC = readdlm("Imagem_corrigida.dat")
LC = reverse(LC, dims=1) #  O padrão no heatmap tem a origem (0,0) no canto inferior esquerdo, e as coordenadas aumentam para cima e para a direita.
heatmap(LC, color=:grays)