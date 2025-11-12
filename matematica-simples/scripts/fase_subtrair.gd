extends Node2D

@onready var campo_texto = $texto
@onready var botoes = [$botao1, $botao2, $botao3]
@onready var bg = $bg
@onready var som_acerto = $som_acerto
@onready var som_erro = $som_erro
@onready var pontuacao_texto = $pontuacao
var textura_verde = preload("res://assets/bg_verdee.jpg")
var textura_vermelha = preload("res://assets/bg_vermelho.png")
var background = preload("res://assets/bg_azul.webp")
var pontuacao: int

var resposta_certa: int

func _ready() -> void:
	pontuacao_texto.text = str(pontuacao)
	gerar_questao()

	for botao in botoes:
		botao.pressed.connect(func(): _on_botao_pressed(botao))

	

func gerar_questao():
	
	var n1 := randi_range(1, 10)
	var n2 := randi_range(1, 10)
	while  n1 - n2 < 0:
		n1 = randi_range(1, 10)
		n2 = randi_range(1, 10)
	resposta_certa = n1 - n2
	var fake1 := n1 + n2 + 1
	var fake2 := n1 + n2 -1

	campo_texto.text = str(n1, "-", n2)
	
	var respostas = [resposta_certa]
	respostas.append(fake1)
	respostas.append(fake2)
	respostas.shuffle()
	for i in range(3):
		botoes[i].text = str(respostas[i])

func _process(delta: float) -> void:
	pass


func _on_botao_pressed(botao) -> void:
	var valor = int(botao.text)
	if valor == resposta_certa:
		pontuacao += 1
		pontuacao_texto.text = str(pontuacao)
		som_acerto.play()
		bg.color = Color(0.004, 0.723, 0.0, 1.0)
		await get_tree().create_timer(0.5).timeout
		bg.color = Color(0.192, 0.42, 1.002)
		gerar_questao()
		if pontuacao == 10:
			get_tree().change_scene_to_file("res://actors/fase_somar.tscn")
	else:
		som_erro.play()
		bg.color =Color(0.804, 0.035, 0.0, 1.0)
		await get_tree().create_timer(0.5).timeout
		bg.color = Color(0.192, 0.42, 1.002)
		gerar_questao()
		
