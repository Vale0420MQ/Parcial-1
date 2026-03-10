#[a-z]+ ( -> | X ) [a-z]+ [0-9]*

ESTADO_INICIAL     = 'q0'
ESTADOS_ACEPTACION = {'q4', 'q5'}

TRANSICIONES = {
    'q0': {'letra': 'q1', 'digito': 'qe', '-': 'qe', '>': 'qe', 'X': 'qe', 'otro': 'qe'},
    'q1': {'letra': 'q1', 'digito': 'qe', '-': 'q2', '>': 'qe', 'X': 'q3', 'otro': 'qe'},
    'q2': {'letra': 'qe', 'digito': 'qe', '-': 'qe', '>': 'q3', 'X': 'qe', 'otro': 'qe'},
    'q3': {'letra': 'q4', 'digito': 'qe', '-': 'qe', '>': 'qe', 'X': 'qe', 'otro': 'qe'},
    'q4': {'letra': 'q4', 'digito': 'q5', '-': 'qe', '>': 'qe', 'X': 'qe', 'otro': 'qe'},
    'q5': {'letra': 'qe', 'digito': 'q5', '-': 'qe', '>': 'qe', 'X': 'qe', 'otro': 'qe'},
    'qe': {'letra': 'qe', 'digito': 'qe', '-': 'qe', '>': 'qe', 'X': 'qe', 'otro': 'qe'},
}

def clasificar(c: str) -> str:
    if c.islower():  
        return 'letra'
    if c.isdigit():  
        return 'digito'
    if c == '-':     
        return '-'
    if c == '>':     
        return '>'
    if c == 'X':     
        return 'X'
    return 'otro'

def ejecutar_afd(cadena: str, verbose: bool = False) -> bool:
    estado = ESTADO_INICIAL

    if verbose:
        print(f"  Inicio -> estado: {estado}")

    for char in cadena:
        cat   = clasificar(char)
        nuevo = TRANSICIONES[estado].get(cat, 'qe')

        if verbose:
            print(f"  '{char}' (cat={cat}) : {estado} -> {nuevo}")
        estado = nuevo

    aceptado = estado in ESTADOS_ACEPTACION

    if verbose:
        print(f"  Estado final: {estado} -> {'ACEPTADA' if aceptado else 'RECHAZADA'}")
    return aceptado


casos = [
    ("p->k4",      True),
    ("kbpXqn",     True),
    ("kbpXqn5",    True),
    ("nXp",        True),
    ("abc->xyz99", True),
    ("kbp X qn",   False),
    ("->k4",       False),
    ("p->",        False),
    ("p->4k",      False),
    ("pXX",        False),
]

for cadena, esperado in casos:
    resultado = ejecutar_afd(cadena)
    marca = "OK" if resultado == esperado else "ERROR"
    print(f"  [{marca}] '{cadena}' -> {'ACEPTADA' if resultado else 'RECHAZADA'}")

print("\nPaso a paso (ejemplos del enunciado):")
for ej in ["p->k4", "kbpXqn"]:
    print(f"\n  Cadena: '{ej}'")
    ejecutar_afd(ej, verbose=True)