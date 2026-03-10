def afd_id(cadena): 
    if not cadena:
        return False, "NO ACEPTE"

    estado = "q0"

    for i, char in enumerate(cadena):
        if estado == "q0":
            if char.isalpha():
                estado = "q1"
            else:
                estado = "qm"
                break

        elif estado == "q1":
            if char.isalpha() or char.isdigit():
                estado = "q1"
            else:
                estado = "qm"
                break

    if estado == "q1":
        return True, "ACEPTADO"
    else:
        return False, "NO ACEPTADO"

pruebas = [
    "miVariable",
    "X99",
    "abc123",
    "1variable",
    "_nombre",
]

for cadena in pruebas:
    _, resultado = afd_id(cadena)
    print(f"{cadena:<15} {resultado}")
