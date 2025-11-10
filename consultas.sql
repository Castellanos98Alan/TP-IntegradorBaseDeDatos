use tp_integrador;

-- i. Listar los proyectos premiados con sus integrantes y coordinador por categoría por expo. 

SELECT 
  pr.nombre AS Proyecto,
  p.tipo AS Categoria_Premio,
  est.nombre AS Integrante,
  d.nombreCompleto AS Coordinador
FROM premio p
JOIN proyecto pr ON p.COD_PROYECTO = pr.COD
JOIN stand st ON pr.COD = st.COD_PROYECTO
JOIN evento ev ON ev.idEvento = st.ID_EVENTO
JOIN estudiante est ON est.COD_PROYECTO = pr.COD
JOIN pertenece pe ON pe.id_Stand = st.ID
JOIN docente d ON d.legajo = pe.legajo_docente
WHERE p.COD_PROYECTO IS NOT NULL
ORDER BY ev.nombre, p.tipo, pr.nombre, est.nombre;

-- ii. Mostrar la agenda día por día de todas las actividades ofrecidas en las Expos.

Select fecha_hora, nombre from actividad
order by fecha_hora ;

-- iii. Generar una consulta que permita filtrar proyectos por los tags generados por IA
-- según la data de cada proyecto. 

SELECT 
  pr.COD AS Codigo_Proyecto,
  pr.nombre AS Nombre_Proyecto,
  pr.lista_tags AS Tags
FROM proyecto pr
WHERE pr.lista_tags LIKE "%IA,%" OR pr.lista_tags LIKE "%,_IA%";

-- iv. Crear una vista que muestre un resumen completo del perfil del proyecto con
-- toda la data asociada. 

CREATE  VIEW vista_resumen_proyecto AS
SELECT 
    p.COD,
    p.nombre AS Proyecto,
    p.descripcion,
    p.objetivo,
    p.lista_tags,
    pr.tipo AS Premio,
    e.nombre AS Estudiante,
    e.carrera,
    est.Nombre AS Establecimiento,
    d.NombreCompleto AS Coordinador,
    ev.nombre AS Expo,
    s.descripcion AS Stand
FROM proyecto p
LEFT JOIN premio pr ON p.COD = pr.COD_PROYECTO
LEFT JOIN estudiante e ON e.COD_PROYECTO = p.COD
LEFT JOIN establecimiento est ON est.idEstablecimiento = e.ID_ESTABLECIMIENTO
LEFT JOIN stand s ON s.COD_PROYECTO = p.COD
LEFT JOIN evento ev ON ev.idEvento = s.ID_EVENTO
LEFT JOIN pertenece pe ON pe.id_Stand = s.ID
LEFT JOIN docente d ON d.legajo = pe.legajo_docente;


-- Consultar la vista:
 SELECT * FROM vista_resumen_proyecto;
-- 

-- v. Mostrar las carreras predominantes en los proyectos presentados en orden
-- decreciente con cantidad de proyectos por cada una y por establecimiento

SELECT es.carrera from estudiante es;