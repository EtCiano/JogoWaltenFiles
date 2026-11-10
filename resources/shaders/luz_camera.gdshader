shader_type canvas_item;

uniform vec2 centro = vec2(0.5, 0.5);   // posição da luz em UV (0 a 1)
uniform float raio : hint_range(0.0, 2.0) = 0.3;
uniform float suavidade : hint_range(0.0, 2.0) = 0.4;
uniform float escuridao : hint_range(0.0, 1.0) = 0.85;
uniform float aspecto = 1.777;          // largura / altura da tela

void fragment() {
	float d = length((UV - centro) * vec2(aspecto, 1.0));
	float luz = 1.0 - smoothstep(raio, raio + suavidade, d);
	COLOR = vec4(0.0, 0.0, 0.0, escuridao * (1.0 - luz));
}