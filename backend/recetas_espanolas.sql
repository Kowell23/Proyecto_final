
USE recetas_db;

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Arroz con Bogavante',
 'Arroz semicaldoso con bogavante, un plato espectacular de dificultad media.',
 '1. Corta el bogavante en rodajas, comenzando por la cabeza. Reserva los jugos.\n2. Pica finamente el ajo, la cebolla y el pimiento rojo.\n3. Sofríe las verduras en aceite de oliva durante 10 minutos a fuego medio.\n4. Incorpora las cabezas del bogavante y saltea con las verduras. Salpimenta.\n5. Ralla el tomate y añádelo junto con el pimentón dulce. Remueve.\n6. Incorpora el arroz bomba y remueve 2 minutos para que absorba el sabor.\n7. Vierte el fumet de pescado caliente (3.5 partes de caldo por 1 de arroz).\n8. Sube el fuego hasta que hierva y bájalo. Añade el azafrán. Cocina 18-20 minutos.\n9. Cuando falten 5 minutos, añade los trozos restantes de bogavante.\n10. Retira del fuego y deja reposar 2-3 minutos. Debe conservar un poco de caldo.',
 'Platos Principales', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('bogavante'),('cebolla'),('ajo'),('tomate maduro'),('pimiento rojo'),('pimentón dulce'),('azafrán'),('arroz bomba'),('fumet de pescado'),('aceite de oliva virgen extra'),('sal'),('pimienta negra');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 piezas de 800-900g' FROM ingredients WHERE name='bogavante';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 grande' FROM ingredients WHERE name='cebolla';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 dientes' FROM ingredients WHERE name='ajo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '4 grandes' FROM ingredients WHERE name='tomate maduro';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 unidad' FROM ingredients WHERE name='pimiento rojo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 cucharadita' FROM ingredients WHERE name='pimentón dulce';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, 'unas hebras' FROM ingredients WHERE name='azafrán';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '500g' FROM ingredients WHERE name='arroz bomba';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 litros' FROM ingredients WHERE name='fumet de pescado';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '100ml' FROM ingredients WHERE name='aceite de oliva virgen extra';

-- ──────────────────────────────────────────────────────────

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Paella Valenciana',
 'La receta más icónica de la cocina española, con pollo, conejo y verduras frescas.',
 '1. Calienta el aceite en una paella grande a fuego medio-alto.\n2. Sofríe el pollo y el conejo troceados hasta dorarlos bien por todos lados. Reserva.\n3. Añade las judías verdes y las garrofons. Sofríe 5 minutos.\n4. Incorpora el tomate rallado y el pimentón. Remueve rápidamente para que no se queme.\n5. Añade el agua o caldo caliente (el doble de volumen que de arroz). Lleva a ebullición.\n6. Sazona con sal y añade el azafrán.\n7. Incorpora el arroz distribuyéndolo uniformemente. Cocina a fuego alto 5 minutos.\n8. Baja el fuego y cocina 12-15 minutos más sin remover.\n9. Sube el fuego los últimos 2 minutos para conseguir el socarrat (base tostada).\n10. Retira del fuego, cubre con papel de periódico y deja reposar 5 minutos.',
 'Platos Principales', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('pollo troceado'),('conejo troceado'),('judías verdes planas'),('garrofons'),('tomate rallado'),('arroz de Valencia');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '500g' FROM ingredients WHERE name='pollo troceado';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '500g' FROM ingredients WHERE name='conejo troceado';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '200g' FROM ingredients WHERE name='judías verdes planas';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '100g' FROM ingredients WHERE name='garrofons';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 cucharadas' FROM ingredients WHERE name='tomate rallado';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '400g' FROM ingredients WHERE name='arroz de Valencia';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 cucharadita' FROM ingredients WHERE name='pimentón dulce';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, 'unas hebras' FROM ingredients WHERE name='azafrán';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '100ml' FROM ingredients WHERE name='aceite de oliva virgen extra';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, 'al gusto' FROM ingredients WHERE name='sal';

-- ──────────────────────────────────────────────────────────

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Fabada Asturiana',
 'El cocido más contundente de Asturias, con fabes blancas y compango.',
 '1. La noche anterior, pon las fabes en remojo cubiertas de agua fría.\n2. Al día siguiente, escurre las fabes y ponlas en una cazuela grande con agua fría.\n3. Añade el chorizo, la morcilla, el tocino y el lacón.\n4. Lleva a ebullición y espuma bien. Baja el fuego y cocina a fuego lento.\n5. A mitad de cocción, añade el azafrán y el pimentón.\n6. Cocina durante 2-3 horas hasta que las fabes estén muy tiernas.\n7. Comprueba la sal y rectifica si es necesario.\n8. Sirve muy caliente, con el compango troceado encima.',
 'Platos Principales', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('fabes asturianas'),('chorizo asturiano'),('morcilla asturiana'),('tocino'),('lacón');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '500g' FROM ingredients WHERE name='fabes asturianas';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 unidades' FROM ingredients WHERE name='chorizo asturiano';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 unidades' FROM ingredients WHERE name='morcilla asturiana';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '200g' FROM ingredients WHERE name='tocino';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '300g' FROM ingredients WHERE name='lacón';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, 'unas hebras' FROM ingredients WHERE name='azafrán';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 cucharadita' FROM ingredients WHERE name='pimentón dulce';

-- ──────────────────────────────────────────────────────────

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Albóndigas en Salsa de Tomate',
 'Clásicas albóndigas jugosas bañadas en salsa de tomate casera.',
 '1. Mezcla la carne picada con el huevo, el ajo picado, el perejil, la sal y la pimienta.\n2. Forma las albóndigas con las manos húmedas y enharínalas.\n3. Dóralas en aceite de oliva por todos lados. Reserva.\n4. En la misma sartén, sofríe la cebolla y el ajo picados 10 minutos.\n5. Añade el tomate triturado y cocina 15 minutos a fuego medio.\n6. Incorpora las albóndigas a la salsa y cocina 20 minutos más a fuego lento.\n7. Comprueba la sal y sirve caliente.',
 'Platos Principales', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('carne picada mixta'),('huevo'),('perejil'),('harina'),('tomate triturado');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '500g' FROM ingredients WHERE name='carne picada mixta';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 unidad' FROM ingredients WHERE name='huevo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 dientes' FROM ingredients WHERE name='ajo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, 'al gusto' FROM ingredients WHERE name='perejil';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '400g' FROM ingredients WHERE name='tomate triturado';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 unidad' FROM ingredients WHERE name='cebolla';

-- ──────────────────────────────────────────────────────────

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Pollo al Ajillo',
 'Pollo de corral dorado con ajo, vino blanco y hierbas aromáticas.',
 '1. Trocea el pollo en piezas medianas y salpimienta.\n2. Dora el pollo en aceite de oliva a fuego fuerte hasta que esté bien dorado.\n3. Añade los ajos enteros sin pelar y cocina 2 minutos.\n4. Vierte el vino blanco y el brandy. Flambea con cuidado o deja evaporar el alcohol.\n5. Añade el laurel y el tomillo.\n6. Baja el fuego, tapa y cocina 25-30 minutos a fuego lento.\n7. Destapa los últimos 5 minutos para que reduzca la salsa.\n8. Sirve con los ajos confitados.',
 'Platos Principales', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('pollo de corral'),('vino blanco'),('brandy'),('laurel'),('tomillo');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 unidad' FROM ingredients WHERE name='pollo de corral';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 cabeza' FROM ingredients WHERE name='ajo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '150ml' FROM ingredients WHERE name='vino blanco';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '50ml' FROM ingredients WHERE name='brandy';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 hojas' FROM ingredients WHERE name='laurel';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '100ml' FROM ingredients WHERE name='aceite de oliva virgen extra';

-- ══════════════════════════════════════════════════════════
-- SOPAS Y CREMAS (CENAS)
-- ══════════════════════════════════════════════════════════

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Caldo Gallego',
 'Caldo tradicional gallego con habas, berza, patata, chorizo y carne de cerdo.',
 '1. La noche anterior, pon las habas en remojo cubiertas de agua fría durante 12 horas.\n2. Escurre las habas y ponlas en una cazuela grande con 5 litros de agua.\n3. Añade el chorizo, la ternera, el unto y las carnes saladas de cerdo.\n4. Lleva a ebullición espumando con frecuencia. Cocina a fuego medio 1 hora.\n5. Pela las patatas y córtalas en dados. Añádelas cuando falten 10 minutos para terminar.\n6. Lava y trocea la berza. Añádela junto con las patatas y cocina 20 minutos más.\n7. Comprueba el punto de sal.\n8. Retira la carne y el chorizo, trocéalos pequeños y devuélvelos al caldo.\n9. Termina con un chorrito de aceite de oliva virgen extra y sirve muy caliente.',
 'Cenas', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('habas blancas secas'),('ternera xarrete'),('berza'),('unto'),('chorizo gallego'),('costilla salada');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '200g' FROM ingredients WHERE name='habas blancas secas';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '300g' FROM ingredients WHERE name='ternera xarrete';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '4 unidades' FROM ingredients WHERE name='Patata';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '300g' FROM ingredients WHERE name='berza';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '50g' FROM ingredients WHERE name='unto';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 unidad' FROM ingredients WHERE name='chorizo gallego';

-- ──────────────────────────────────────────────────────────

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Crema de Calabacín',
 'Crema suave y reconfortante de calabacín, perfecta para cualquier noche.',
 '1. Pela y trocea los calabacines en dados.\n2. Pela y trocea la cebolla y las patatas.\n3. Sofríe la cebolla en aceite de oliva 5 minutos.\n4. Añade los calabacines y las patatas. Rehoga 5 minutos más.\n5. Cubre con el caldo de verduras y lleva a ebullición.\n6. Cocina 20 minutos hasta que todo esté tierno.\n7. Tritura con la batidora hasta obtener una crema fina.\n8. Añade la nata, salpimenta y ajusta la textura con más caldo si es necesario.\n9. Sirve caliente con un hilo de aceite de oliva y pimienta negra.',
 'Cenas', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('calabacín'),('caldo de verduras'),('nata para cocinar');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '4 unidades' FROM ingredients WHERE name='calabacín';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 unidad' FROM ingredients WHERE name='cebolla';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 unidades' FROM ingredients WHERE name='Patata';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '800ml' FROM ingredients WHERE name='caldo de verduras';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '100ml' FROM ingredients WHERE name='nata para cocinar';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '3 cucharadas' FROM ingredients WHERE name='aceite de oliva virgen extra';

-- ──────────────────────────────────────────────────────────

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Sopa de Ajo o Sopa Castellana',
 'La sopa más sencilla y humilde de Castilla, con pan, ajo, pimentón y huevo.',
 '1. Lamina los ajos y dóralos en aceite de oliva en una cazuela de barro a fuego lento.\n2. Cuando estén dorados, añade el pimentón y remueve rápidamente (que no se queme).\n3. Añade el pan del día anterior cortado en rebanadas finas.\n4. Vierte el agua o caldo caliente. Sazona con sal.\n5. Cocina a fuego lento 10 minutos hasta que el pan se ablande.\n6. Casca los huevos directamente en la sopa y escalfálos tapando la cazuela 3-4 minutos.\n7. Sirve inmediatamente en la misma cazuela de barro.',
 'Cenas', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('pan del día anterior');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '6 dientes' FROM ingredients WHERE name='ajo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '200g' FROM ingredients WHERE name='pan del día anterior';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 cucharadita' FROM ingredients WHERE name='pimentón dulce';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '4 unidades' FROM ingredients WHERE name='huevo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1.5 litros' FROM ingredients WHERE name='caldo de verduras';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '4 cucharadas' FROM ingredients WHERE name='aceite de oliva virgen extra';

-- ══════════════════════════════════════════════════════════
-- SIN HORNO (Recetas que no requieren horno)
-- ══════════════════════════════════════════════════════════

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Gazpacho Andaluz',
 'La sopa fría más famosa de España, refrescante y llena de vitaminas.',
 '1. Lava y trocea los tomates, el pepino, el pimiento y el ajo.\n2. Pon todas las verduras en el vaso de la batidora.\n3. Añade el pan del día anterior previamente remojado en agua.\n4. Agrega el aceite de oliva, el vinagre y la sal.\n5. Tritura todo hasta obtener una crema fina.\n6. Pasa por el chino o colador fino para eliminar pieles y pepitas.\n7. Ajusta la textura con agua fría si está muy espeso.\n8. Refrigera al menos 2 horas antes de servir.\n9. Sirve muy frío con guarnición de pepino, tomate y pimiento picados.',
 'Sin Horno', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('tomate pera'),('pepino'),('pimiento verde'),('vinagre de jerez');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1kg' FROM ingredients WHERE name='tomate pera';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 unidad' FROM ingredients WHERE name='pepino';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 unidad' FROM ingredients WHERE name='pimiento verde';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 diente' FROM ingredients WHERE name='ajo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '100g' FROM ingredients WHERE name='pan del día anterior';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '100ml' FROM ingredients WHERE name='aceite de oliva virgen extra';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 cucharadas' FROM ingredients WHERE name='vinagre de jerez';

-- ──────────────────────────────────────────────────────────

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Salmorejo Cordobés',
 'Crema fría de tomate más espesa que el gazpacho, típica de Córdoba.',
 '1. Trocea los tomates maduros y ponlos en el vaso de la batidora.\n2. Añade el pan duro previamente remojado en agua.\n3. Incorpora el ajo, el aceite de oliva y la sal.\n4. Tritura hasta obtener una crema muy fina y homogénea.\n5. Pasa por el chino para eliminar pieles.\n6. Refrigera al menos 2 horas.\n7. Sirve frío con huevo duro picado y jamón ibérico en tiras.',
 'Sin Horno', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('pan duro tipo telera'),('jamón ibérico');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1kg' FROM ingredients WHERE name='tomate pera';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '200g' FROM ingredients WHERE name='pan duro tipo telera';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 diente' FROM ingredients WHERE name='ajo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '100ml' FROM ingredients WHERE name='aceite de oliva virgen extra';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 unidades' FROM ingredients WHERE name='huevo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '80g' FROM ingredients WHERE name='jamón ibérico';

-- ──────────────────────────────────────────────────────────

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Tortilla de Patatas al Estilo Betanzos',
 'La famosa tortilla jugosa y poco cuajada de Betanzos, un clásico gallego.',
 '1. Pela las patatas y córtalas en láminas finas o en dados pequeños.\n2. Calienta abundante aceite de oliva en una sartén grande.\n3. Fríe las patatas a fuego medio-bajo durante 20-25 minutos hasta que estén tiernas.\n4. Escurre las patatas del aceite y salpimiéntalas.\n5. Bate los huevos con una pizca de sal en un cuenco grande.\n6. Mezcla las patatas con los huevos batidos.\n7. Calienta un poco del aceite en la sartén y vierte la mezcla.\n8. Cocina a fuego medio. Da la vuelta con un plato cuando los bordes estén cuajados.\n9. El centro debe quedar jugoso y poco hecho. Sirve inmediatamente.',
 'Sin Horno', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '4 medianas' FROM ingredients WHERE name='Patata';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '6 unidades' FROM ingredients WHERE name='huevo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, 'abundante' FROM ingredients WHERE name='aceite de oliva virgen extra';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, 'al gusto' FROM ingredients WHERE name='sal';

-- ──────────────────────────────────────────────────────────

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Migas Extremeñas',
 'Contundente plato de migas de pan con panceta, chorizo y pimientos. Receta de la abuela.',
 '1. Corta el pan del día anterior en trozos. Humedécelo con agua poco a poco.\n2. Cubre con un paño limpio y deja reposar toda la noche.\n3. Al día siguiente, trocea la panceta y el chorizo.\n4. Dora la panceta en una cazuela honda. Irá soltando su propia grasa.\n5. Haz un corte profundo en cada ajo e incorpóralo con más aceite si es necesario. Sofríe 2-3 minutos.\n6. Añade el chorizo y sofríe unos minutos. Retíralo dejando su jugo.\n7. Incorpora las migas a la cazuela. Mezcla bien con el aceite de panceta y chorizo.\n8. Añade sal y el pimentón de la Vera. Remueve y cocina 25 minutos a fuego lento sin dejar de vigilar.\n9. Mientras, sofríe los pimientos troceados en otra sartén 8-10 minutos.\n10. Cuando las migas estén listas, añade la panceta, los ajos, el chorizo y los pimientos. Remueve y sirve caliente.',
 'Sin Horno', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('panceta'),('pimentón de la Vera');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '500g' FROM ingredients WHERE name='pan del día anterior';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '150ml' FROM ingredients WHERE name='Agua';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '150g' FROM ingredients WHERE name='panceta';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '150g' FROM ingredients WHERE name='chorizo gallego';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '3 dientes' FROM ingredients WHERE name='ajo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 unidades' FROM ingredients WHERE name='pimiento verde';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '½ cucharadita' FROM ingredients WHERE name='pimentón de la Vera';

-- ══════════════════════════════════════════════════════════
-- ENSALADAS
-- ══════════════════════════════════════════════════════════

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Pipirrana Andaluza',
 'Ensalada fría andaluza de tomate, pimiento, huevo y atún con majado de ajo.',
 '1. Cuece los huevos 15 minutos. Pélalos y separa las yemas de las claras. Reserva.\n2. Maja los ajos con la sal gruesa en un mortero hasta obtener una crema.\n3. Añade las yemas cocidas al mortero y sigue majando hasta tener una pasta homogénea.\n4. Incorpora el aceite de oliva poco a poco majando. Reserva el majado.\n5. Pica finamente el pimiento verde retirando el pedúnculo y las semillas.\n6. Pela los tomates (escáldalos en agua hirviendo 30 segundos) y córtalos en dados.\n7. Pica las claras cocidas.\n8. Mezcla las verduras, las claras y el majado en una ensaladera.\n9. Guarda en el frigorífico mínimo 2 horas.\n10. Al servir, incorpora el atún escurrido, mezcla y sirve frío.',
 'Ensaladas', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('atún en aceite de oliva'),('sal gruesa');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '750g' FROM ingredients WHERE name='tomate pera';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 unidad' FROM ingredients WHERE name='pimiento verde';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 unidades' FROM ingredients WHERE name='huevo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 dientes' FROM ingredients WHERE name='ajo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '½ cucharadita' FROM ingredients WHERE name='sal gruesa';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '50ml' FROM ingredients WHERE name='aceite de oliva virgen extra';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 lata' FROM ingredients WHERE name='atún en aceite de oliva';

-- ──────────────────────────────────────────────────────────

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Ensaladilla Rusa',
 'La tapa más popular de España, cremosa y llena de sabor.',
 '1. Cuece las patatas y las zanahorias enteras con piel en agua con sal durante 20-25 minutos.\n2. Cuece los huevos 12 minutos. Enfría bajo el grifo y pélalos.\n3. Cuece las judías verdes en agua con sal 8 minutos. Escurre y enfría.\n4. Pela las patatas y las zanahorias una vez frías y córtalas en dados pequeños.\n5. Pica los huevos, las judías, las aceitunas y los pepinillos.\n6. Mezcla todo con la mayonesa hasta obtener una ensaladilla cremosa.\n7. Rectifica la sal y refrigera al menos 1 hora.\n8. Sirve fría decorada con aceitunas, huevo y atún.',
 'Ensaladas', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('zanahoria'),('judías verdes'),('aceitunas'),('pepinillos'),('mayonesa');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '4 medianas' FROM ingredients WHERE name='Patata';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 unidades' FROM ingredients WHERE name='zanahoria';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '3 unidades' FROM ingredients WHERE name='huevo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '100g' FROM ingredients WHERE name='judías verdes';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 lata' FROM ingredients WHERE name='atún en aceite de oliva';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '200g' FROM ingredients WHERE name='mayonesa';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, 'al gusto' FROM ingredients WHERE name='aceitunas';

-- ══════════════════════════════════════════════════════════
-- DESAYUNOS
-- ══════════════════════════════════════════════════════════

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Churros',
 'Los churros más crujientes para desayunar con chocolate caliente.',
 '1. Lleva el agua con la sal a ebullición en un cazo.\n2. Retira del fuego y añade la harina de golpe. Remueve enérgicamente con una cuchara de madera hasta obtener una masa homogénea sin grumos.\n3. Deja templar la masa 5 minutos.\n4. Introduce la masa en una churrera o manga pastelera con boquilla estrellada.\n5. Calienta abundante aceite en una sartén honda a 180°C.\n6. Forma los churros directamente sobre el aceite caliente, cortándolos con unas tijeras.\n7. Fríe hasta que estén dorados y crujientes, girándolos a mitad de la fritura.\n8. Escurre sobre papel absorbente y espolvorea con azúcar.\n9. Sirve inmediatamente con chocolate caliente.',
 'Desayunos', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('harina de trigo'),('azúcar');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '250ml' FROM ingredients WHERE name='Agua';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '250g' FROM ingredients WHERE name='harina de trigo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 pizca' FROM ingredients WHERE name='Sal';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, 'para freír' FROM ingredients WHERE name='aceite de oliva virgen extra';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, 'para espolvorear' FROM ingredients WHERE name='azúcar';

-- ──────────────────────────────────────────────────────────

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Torrijas',
 'El dulce más tradicional de Semana Santa, esponjoso y aromático.',
 '1. Calienta la leche con la canela en rama, la piel de limón y el azúcar sin que llegue a hervir.\n2. Retira del fuego y deja infusionar 15 minutos. Cuela.\n3. Corta el pan en rebanadas de 2 cm de grosor.\n4. Sumerge las rebanadas en la leche templada y deja que absorban bien.\n5. Pasa las torrijas por huevo batido.\n6. Fríe en aceite caliente hasta que estén doradas por ambos lados.\n7. Escurre sobre papel absorbente.\n8. Mezcla azúcar con canela molida y reboza las torrijas.\n9. Sirve templadas o frías.',
 'Desayunos', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('leche entera'),('canela en rama'),('piel de limón'),('canela molida');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 barra' FROM ingredients WHERE name='pan del día anterior';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '500ml' FROM ingredients WHERE name='leche entera';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 rama' FROM ingredients WHERE name='canela en rama';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 tira' FROM ingredients WHERE name='piel de limón';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '3 cucharadas' FROM ingredients WHERE name='azúcar';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 unidades' FROM ingredients WHERE name='huevo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 cucharadita' FROM ingredients WHERE name='canela molida';

-- ══════════════════════════════════════════════════════════
-- ALMUERZOS
-- ══════════════════════════════════════════════════════════

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Macarrones Gratinados',
 'Macarrones al horno gratinados con bechamel y queso, reconfortantes y deliciosos.',
 '1. Cuece los macarrones en agua con sal según las instrucciones del paquete. Escurre y reserva.\n2. Sofríe la cebolla y el ajo picados en aceite de oliva 8 minutos.\n3. Añade la carne picada y cocina hasta que esté dorada. Salpimienta.\n4. Incorpora el tomate triturado y cocina 15 minutos. Rectifica la sal.\n5. Mezcla la pasta con la salsa de carne.\n6. Prepara la bechamel: derrite la mantequilla, añade la harina y remueve. Incorpora la leche poco a poco sin parar de remover. Sazona.\n7. Pon la pasta en una fuente de horno, cubre con la bechamel.\n8. Espolvorea queso rallado generosamente.\n9. Gratina en el horno a 200°C durante 10-15 minutos hasta dorar.',
 'Almuerzos', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('macarrones'),('queso rallado'),('mantequilla'),('leche');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '400g' FROM ingredients WHERE name='macarrones';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '300g' FROM ingredients WHERE name='carne picada mixta';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 unidad' FROM ingredients WHERE name='cebolla';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '400g' FROM ingredients WHERE name='tomate triturado';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '50g' FROM ingredients WHERE name='mantequilla';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '50g' FROM ingredients WHERE name='harina de trigo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '500ml' FROM ingredients WHERE name='leche';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '150g' FROM ingredients WHERE name='queso rallado';

-- ──────────────────────────────────────────────────────────

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Lasaña de Carne',
 'Lasaña tradicional con boloñesa casera, bechamel y queso gratinado.',
 '1. Sofríe la cebolla, el ajo y la zanahoria picados en aceite de oliva 10 minutos.\n2. Añade la carne picada y dora bien. Salpimenta.\n3. Incorpora el tomate triturado, el vino tinto y el laurel. Cocina 30 minutos a fuego lento.\n4. Prepara la bechamel: derrite la mantequilla, añade la harina, luego la leche poco a poco removiendo. Sazona con sal y nuez moscada.\n5. Cuece las placas de lasaña según instrucciones. Escurre.\n6. En una fuente, alterna capas de pasta, boloñesa y bechamel.\n7. Termina con bechamel y queso rallado abundante.\n8. Hornea a 180°C durante 30 minutos.\n9. Gratina 5 minutos más y deja reposar 5 minutos antes de servir.',
 'Almuerzos', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('placas de lasaña'),('vino tinto'),('nuez moscada');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '12 placas' FROM ingredients WHERE name='placas de lasaña';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '500g' FROM ingredients WHERE name='carne picada mixta';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 unidad' FROM ingredients WHERE name='cebolla';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 unidad' FROM ingredients WHERE name='zanahoria';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '400g' FROM ingredients WHERE name='tomate triturado';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '100ml' FROM ingredients WHERE name='vino tinto';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '50g' FROM ingredients WHERE name='mantequilla';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '500ml' FROM ingredients WHERE name='leche';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '150g' FROM ingredients WHERE name='queso rallado';

-- ══════════════════════════════════════════════════════════
-- POSTRES
-- ══════════════════════════════════════════════════════════

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Flan de Huevo Casero',
 'El postre más clásico de la cocina española, suave y caramelizado.',
 '1. Prepara el caramelo: pon el azúcar en un cazo a fuego medio sin remover hasta que se dore.\n2. Vierte el caramelo en los moldes individuales y gira para cubrir el fondo. Reserva.\n3. Calienta la leche con la canela y la piel de limón sin que llegue a hervir. Cuela y deja templar.\n4. Bate los huevos con el azúcar hasta integrar.\n5. Añade la leche templada poco a poco a los huevos sin dejar de remover.\n6. Cuela la mezcla y vierte en los moldes caramelizados.\n7. Hornea al baño maría a 160°C durante 45-50 minutos.\n8. Pincha con un palillo: si sale limpio, están listos.\n9. Deja enfriar y refrigera mínimo 4 horas antes de desmoldar.',
 'Postres', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '500ml' FROM ingredients WHERE name='leche entera';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '4 unidades' FROM ingredients WHERE name='huevo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '150g' FROM ingredients WHERE name='azúcar';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 rama' FROM ingredients WHERE name='canela en rama';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 tira' FROM ingredients WHERE name='piel de limón';

-- ──────────────────────────────────────────────────────────

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Arroz con Leche al Estilo Asturiano',
 'Cremoso arroz con leche asturiano con su característica costra de azúcar quemado.',
 '1. Lava el arroz y ponlo en una cazuela con agua fría. Lleva a ebullición 2 minutos. Escurre.\n2. Calienta la leche con la canela en rama y la piel de limón.\n3. Cuando hierva, añade el arroz escurrido y cocina a fuego muy lento 40-45 minutos removiendo frecuentemente.\n4. Añade el azúcar cuando el arroz esté casi cocido. Remueve bien.\n5. Retira la canela y la piel de limón.\n6. Vierte en cazuelas individuales de barro y deja enfriar.\n7. Refrigera al menos 2 horas.\n8. Justo antes de servir, espolvorea azúcar y quema con un soplete para conseguir la costra caramelizada.',
 'Postres', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('arroz redondo');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '200g' FROM ingredients WHERE name='arroz redondo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1.5 litros' FROM ingredients WHERE name='leche entera';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '150g' FROM ingredients WHERE name='azúcar';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 rama' FROM ingredients WHERE name='canela en rama';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 tira' FROM ingredients WHERE name='piel de limón';

-- ──────────────────────────────────────────────────────────

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Chulas o Fritos de Leche de la Abuela Lucrecia',
 'Dulce frito esponjoso con leche, huevo y limón, rebozado en azúcar y canela.',
 '1. Lava el limón y rállalo con cuidado de no alcanzar la membrana blanca.\n2. En un cuenco, mezcla la leche, la harina, la ralladura de limón, el azúcar, una pizca de sal y los huevos.\n3. Bate con la batidora hasta que no queden grumos.\n4. Deja reposar 1 hora para que espese.\n5. Calienta aceite de oliva en una sartén a temperatura media-alta.\n6. Agrega con un cucharón pequeñas dosis de masa (no muy llenas, aumentan de tamaño).\n7. Cuando estén doradas, ponlas sobre papel absorbente.\n8. Cuando estén templadas, rebózalas en la mezcla de azúcar y canela molida.\n9. Sirve templadas.',
 'Postres', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('ralladura de limón');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 litro' FROM ingredients WHERE name='leche entera';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '500g' FROM ingredients WHERE name='harina de trigo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '150g' FROM ingredients WHERE name='azúcar';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '6 unidades' FROM ingredients WHERE name='huevo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 unidad' FROM ingredients WHERE name='ralladura de limón';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 cucharada' FROM ingredients WHERE name='canela molida';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 pizca' FROM ingredients WHERE name='sal';

-- ──────────────────────────────────────────────────────────

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Tarta de Santiago',
 'La famosa tarta de almendra de Galicia, sin gluten y con la cruz de Santiago.',
 '1. Precalienta el horno a 180°C.\n2. Bate los huevos con el azúcar hasta obtener una mezcla espumosa.\n3. Incorpora las almendras molidas, la ralladura de limón y la naranja, y la canela molida.\n4. Mezcla bien hasta obtener una masa homogénea.\n5. Engrasa un molde redondo y vierte la mezcla.\n6. Hornea 35-40 minutos hasta que esté dorada y cuajada.\n7. Deja enfriar completamente.\n8. Coloca la cruz de Santiago sobre la tarta y espolvorea azúcar glas.\n9. Retira la plantilla y sirve.',
 'Postres', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('almendras molidas'),('ralladura de naranja'),('azúcar glas');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '250g' FROM ingredients WHERE name='almendras molidas';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '4 unidades' FROM ingredients WHERE name='huevo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '200g' FROM ingredients WHERE name='azúcar';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 cucharadita' FROM ingredients WHERE name='ralladura de limón';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 cucharadita' FROM ingredients WHERE name='ralladura de naranja';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '1 cucharadita' FROM ingredients WHERE name='canela molida';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, 'para decorar' FROM ingredients WHERE name='azúcar glas';

-- ══════════════════════════════════════════════════════════
-- BEBIDAS
-- ══════════════════════════════════════════════════════════

INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Ajoblanco Malagueño',
 'Sopa fría de almendras y ajo, refrescante bebida-sopa de Málaga.',
 '1. Remoja el pan en agua fría 10 minutos. Escurre y exprime.\n2. Pela las almendras (escáldalas en agua hirviendo y pélalas).\n3. Tritura las almendras con el ajo, el pan escurrido y la sal hasta obtener una pasta fina.\n4. Añade el aceite poco a poco como si fuera una mayonesa, sin dejar de triturar.\n5. Incorpora el vinagre y ve añadiendo agua fría hasta obtener la textura deseada.\n6. Ajusta la sal y refrigera al menos 2 horas.\n7. Sirve muy frío con uvas blancas o melón.',
 'Bebidas', 1);

SET @id = LAST_INSERT_ID();
INSERT IGNORE INTO ingredients (name) VALUES ('almendras crudas peladas'),('vinagre de vino blanco');
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '200g' FROM ingredients WHERE name='almendras crudas peladas';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 rebanadas' FROM ingredients WHERE name='pan del día anterior';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 dientes' FROM ingredients WHERE name='ajo';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '100ml' FROM ingredients WHERE name='aceite de oliva virgen extra';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '2 cucharadas' FROM ingredients WHERE name='vinagre de vino blanco';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, '400-600ml' FROM ingredients WHERE name='Agua';
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) SELECT @id, id, 'al gusto' FROM ingredients WHERE name='sal';
