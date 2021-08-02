-- POKEMON:
-- 1. mostrar los pokemon con una estadística base de ps mayor que 200 y que no evolucionan de otro pokemon.
SELECT p.nombre
FROM pokemon p,estadisticas_base eb, evoluciona_de ed
WHERE p.numero_pokedex = eb.numero_pokedex
AND eb.ps >200
AND ed.pokemon_origen <> p.numero_pokedex
AND ed.pokemon_evolucionado <> p.numero_pokedex
-- 2. mostrar los pokemon que son de tipo hielo o veneno, que tengan una ataque que permitan como efecto secundario paralizar.
SELECT p.nombre,m.nombre ,t.nombre , es.efecto_secundario
FROM pokemon p, pokemon_tipo pt, tipo t, pokemon_movimiento_forma pmf , movimiento m ,movimiento_efecto_secundario mes,efecto_secundario es
WHERE p.numero_pokedex = pt.numero_pokedex
AND pt.id_tipo =t.id_tipo
AND pmf.numero_pokedex = p.numero_pokedex
AND pmf.id_movimiento =m.id_movimiento
AND m.id_movimiento =mes.id_movimiento
AND mes.id_efecto_secundario = es.id_efecto_secundario
AND t.nombre IN ("Hielo","Veneno")
AND es.efecto_secundario = "paralizar"
-- 3. mostrar los pokemon que tengan movimientos cuya potencia del movimiento es cero, ordena la información por el campo pp descendentemente.
SELECT p.nombre, m.nombre ,m.pp
FROM pokemon p, pokemon_movimiento_forma pmf, movimiento m
WHERE p.numero_pokedex = pmf.numero_pokedex
AND pmf.id_movimiento = m.id_movimiento
AND m.potencia = "0"
ORDER BY m.pp DESC
-- 4. mostrar los pokemon y la información de sus estadísticas base, de aquellos pokemon que evolucionan de otros pokemon con una estadística de velocidad superior a 100 ordenados de mayor a menor por ataque, y después por el poder de defensa de menor a mayor.
SELECT p.nombre, eb.*
FROM pokemon p, estadisticas_base eb, evoluciona_de ed
WHERE  p.numero_pokedex =eb.numero_pokedex
AND eb.velocidad >100
AND ed.pokemon_evolucionado =p.numero_pokedex
ORDER BY eb.ataque DESC, eb.defensa ASC
-- 5. mostrar los ataques que sean de tipo especial y los pokemon que usan estos ataques.
SELECT p.*, m.* from pokemon p, tipo_ataque ta, movimiento m, pokemon_movimiento_forma pmf, tipo t
WHERE ta.tipo = "Especial"
AND p.numero_pokedex = pmf.numero_pokedex
AND pmf.id_movimiento = m.id_movimiento
AND m.id_tipo= t.id_tipo
AND ta.id_tipo_ataque = t.id_tipo_ataque
-- LIBRERÍA
-- 6. mostrar los autores y libros cuya fecha de publicación sea anterior al año 2000 ordenados por fecha de publicacion, limitar la consulta a 5 resultados.
SELECT a.nombre ,l.fecha_publicacion
FROM autores a,libros l
WHERE a.autor_id =l.autor_id
AND YEAR (l.fecha_publicacion) < 2000
ORDER BY l.fecha_publicacion
LIMIT 5
-- 7. mostrar el numero de autores nacidos entre 1800 y 1900 de sexo femenino, de los estados unidos USA.
SELECT count(a.nombre)
FROM autores a
WHERE YEAR (a.fecha_nacimiento )<1900
AND YEAR (a.fecha_nacimiento )>1800
AND a.pais_origen ="USA"
AND a.genero = "F"
-- 8. mostrar los libros de los usuarios con cuenta de correo(email) perteneciente al dominio codigo facilito.
SELECT l.*
FROM autores a,libros_usuarios lu ,libros l ,usuarios u
WHERE a.autor_id =l.autor_id
AND l.libro_id =lu.libro_id
AND lu.usuario_id =u.usuario_id
AND u.email LIKE "%codigofacilito%"
-- 9. mostrar los libros de harry potter ordenados por fecha de publicación .
SELECT l.titulo,l.fecha_publicacion
FROM libros l
WHERE l.titulo LIKE "%Harry Potter %"
ORDER BY l.fecha_publicacion
-- 10. mostrar todos los libros extranjeros que empiezan por algún artículo determinante en su título.
SELECT l.titulo, a.pais_origen
FROM libros l, autores a
WHERE (l.titulo LIKE "el%"
OR l.titulo LIKE "la%"
OR l.titulo LIKE "los%"
OR l.titulo LIKE "las%")
AND a.autor_id =l.autor_id
AND a.pais_origen <> "España"

