math.randomseed(os.time())
------------------------------------------------------------------------------------------------------------------------
--- О шаблоне
------------------------------------------------------------------------------------------------------------------------
--- Bladerunner
--- Автор оригинального шаблона: Uchenik
--- Авторы модифицированных версий: Barton, Satonir, Xrystal

------------------------------------------------------------------------------------------------------------------------
--- Глобальные параметры
------------------------------------------------------------------------------------------------------------------------
--- Версия шаблона
local version = '3.1'
------------------------------------------------------------------------------------------------------------------------
--- Варианты режима шаблона
local duo = 2
local trinity = 3
local clover = 4
--- Режим шаблона:
local template_mode = duo
------------------------------------------------------------------------------------------------------------------------
--- Режим игры:
local game_mode = 1
------------------------------------------------------------------------------------------------------------------------
--- Режим сокровищницы:
local treasure_mode = false
------------------------------------------------------------------------------------------------------------------------
--- Режим рынка союзников:
local market_mode = false
------------------------------------------------------------------------------------------------------------------------
--- Режим события:
local event_mode = 1
------------------------------------------------------------------------------------------------------------------------
--- Режим границ центральных зон(лепестков)
--- 1. случайно (для каждой зоны)
--- 2. одинаковые-случайно
--- 3. зеркально-случайно
--- 4. открытые
--- 5. Водные
--- 6. полуоткрытые

local border_mode = 3
------------------------------------------------------------------------------------------------------------------------
--- коэффициент сложности (<0.9 легко; 0.9-1.1 средне; >1.1 сложно) - не применяется к Т0
local kef = 1.0
------------------------------------------------------------------------------------------------------------------------
--- Коэффициент разброса силы нейтралов
local kr = 1.05
------------------------------------------------------------------------------------------------------------------------
--- Цвета зон
------------------------------------------------------------------------------------------------------------------------
--- игрок 1
local c0_1 = 0 -- красный
local c1_1 = 1 -- зелёный
local c2_1 = 2 -- синий
--- игрок 2
local c0_2 = 9 -- оранжевый
local c1_2 = 10 -- темно-зелёный
local c2_2 = 11 -- темно-синий
--- игрок 3
local c0_3 = 8 -- пурпурный
local c1_3 = 6 -- жёлтый
local c2_3 = 7 -- голубой
--- игрок 4
local c0_4 = 12 -- коричневый
local c1_4 = 5 -- серый
local c2_4 = 66 -- тёмно-серый
--- предбанники к центру
local c3_1 = 62 -- почти чёрный
local c3_2 = 139 -- почти чёрный
local c3_3 = 216 -- почти чёрный
local c3_4 = 293 -- почти чёрный
local c3_5 = 370 -- почти чёрный
local c3_6 = 447 -- почти чёрный
--- центр
local c4_1 = 4 -- чёрный
--- сокровищницы
local c5_1 = 66 -- тёмно-серый
local c5_2 = 143 -- тёмно-серый
local c5_3 = 220 -- тёмно-серый
--- пустота
local ce_1 = 55 -- cветло-серый
local ce_2 = 132 -- cветло-серый
local ce_3 = 209 -- cветло-серый
local ce_4 = 286 -- cветло-серый
--- вода
local cw_1 = 70 -- серый
local cw_2 = 147 -- серый
local cw_3 = 224 -- серый
--- рынок союзников (1x2 / 2x2)
local cm_1 = 60 -- белый
local cm_2 = 137 -- белый
----- игрок 1
--local c0_1 = 100 -- красный
--local c1_1 = 101 -- зелёный
--local c2_1 = 102 -- синий
----- игрок 2
--local c0_2 = 200 -- красный
--local c1_2 = 201 -- зелёный
--local c2_2 = 202 -- синий
----- игрок 3
--local c0_3 = 300 -- красный
--local c1_3 = 301 -- зелёный
--local c2_3 = 302 -- синий
----- игрок 4
--local c0_4 = 400 -- красный
--local c1_4 = 401 -- зелёный
--local c2_4 = 402 -- синий
----- предбанники к центру
--local c3_1 = 113 -- т.серый
--local c3_2 = 213 -- т.серый
--local c3_3 = 313 -- т.серый
--local c3_4 = 413 -- т.серый
--local c3_5 = 513 -- т.серый
--local c3_6 = 613 -- т.серый
----- центр
--local c4_1 = 104 -- чёрный
----- сокровищницы
--local c5_1 = 125 -- серый
--local c5_2 = 225 -- серый
--local c5_3 = 325 -- серый
----- пустота
--local ce_1 = 105 -- cветло-серый
--local ce_2 = 205 -- cветло-серый
--local ce_3 = 305 -- cветло-серый
--local ce_4 = 405 -- cветло-серый
----- вода
--local cw_1 = 140 -- серый
--local cw_2 = 150 -- серый
--local cw_3 = 325 -- серый
----- рынок союзников (1x2 / 2x2)
--local cm_1 = 103 -- белый
--local cm_2 = 203 -- белый

------------------------------------------------------------------------------------------------------------------------
--- Технические переменные и константы
------------------------------------------------------------------------------------------------------------------------
--- Расы
local ALL_RACES = {Race.Human, Race.Dwarf, Race.Undead, Race.Heretic, Race.Elf}
local Races = {}
------------------------------------------------------------------------------------------------------------------------
--- Тип предметов для руин т0-т2
local ruinsLootTypes = {Item.Weapon, Item.Armor, Item.Banner, Item.Jewel, Item.TravelItem}
------------------------------------------------------------------------------------------------------------------------
--- Статус сетовых предметов
local setItemsStatus = {}
------------------------------------------------------------------------------------------------------------------------
--- День беса
local iad = math.random(1,6)
------------------------------------------------------------------------------------------------------------------------
--- Забаненные заклинания
local ArrayForbiddenSpells = {}
------------------------------------------------------------------------------------------------------------------------
--- Заклинания
------------------------------------------------------------------------------------------------------------------------
local Spells = {
	-- Основная таблица всех заклинаний с ID как ключ
	--- т1
	--- Human
	g000ss0004	= {	id = 'g000ss0004', 	race = Race.Human, tier = 1, ban = false }, -- Молния - Наносит отряду 10 урона магией.
	g000ss0178	= {	id = 'g000ss0178', 	race = Race.Human, tier = 1, ban = false }, -- Неудача - Уменьшает точность отряда на 10%.
	g000ss0007	= {	id = 'g000ss0007', 	race = Race.Human, tier = 1, ban = false }, -- Исцеление - Восстанавливает 30 очков здоровья.
	g000ss0002	= {	id = 'g000ss0002', 	race = Race.Human, tier = 1, ban = false }, -- Быстрота - Увеличивает инициативу отряда на 7%.
	g000ss0003	= {	id = 'g000ss0003', 	race = Race.Human, tier = 1, ban = false }, -- Сила - Увеличивает урон отряда на 10%.
	g000ss0126	= {	id = 'g000ss0126', 	race = Race.Human, tier = 1, ban = false }, -- Соколиная зоркость - Увеличивает радиус обзора героя на 2.
	g000ss0009	= {	id = 'g000ss0009', 	race = Race.Human, tier = 1, ban = false }, -- Истинное зрение - Открывает участок карты 5х5.
	--- Undead
	g000ss0062	= {	id = 'g000ss0062', 	race = Race.Undead, tier = 1, ban = false }, -- Мор - Наносит отряду 10 урона магией.
	g000ss0064	= {	id = 'g000ss0064', 	race = Race.Undead, tier = 1, ban = false }, -- Слабость - Уменьшает урон и инициативу отряда на 5%.
	g000ss0065	= {	id = 'g000ss0065', 	race = Race.Undead, tier = 1, ban = false }, -- Ржавчина - Уменьшает броню отряда на 10.
	g000ss0134	= {	id = 'g000ss0134', 	race = Race.Undead, tier = 1, ban = false }, -- Порченая руна - Уменьшает точность отряда на 10%.
	g000ss0181	= {	id = 'g000ss0181', 	race = Race.Undead, tier = 1, ban = false }, -- Стальные кости - Увеличивает броню отряда на 7.
	g000ss0061	= {	id = 'g000ss0061', 	race = Race.Undead, tier = 1, ban = false }, -- Призыв I: Скелет - Призывает Скелета на 1 ход.
	--- Heretic
	g000ss0043	= {	id = 'g000ss0043', 	race = Race.Heretic, tier = 1, ban = false }, -- Ignis mare - Наносит отряду 10 урона магией.
	g000ss0044	= {	id = 'g000ss0044', 	race = Race.Heretic, tier = 1, ban = false }, -- Menta minoris - Уменьшает урон и точность отряда на 5%.
	g000ss0045	= {	id = 'g000ss0045', 	race = Race.Heretic, tier = 1, ban = false }, -- Tormentio - Уменьшает броню отряда на 10.
	g000ss0041	= {	id = 'g000ss0041', 	race = Race.Heretic, tier = 1, ban = false }, -- Incantare Hellhound - Призывает Адскую гончую на 1 ход.
	g000ss0042	= {	id = 'g000ss0042', 	race = Race.Heretic, tier = 1, ban = true }, -- Incantare Hellhound Illudere - Призывает фантом Адской гончей на 2 хода.
	--- Dwarf
	g000ss0024	= {	id = 'g000ss0024', 	race = Race.Dwarf, tier = 1, ban = false }, -- Буран - Наносит отряду 10 урона магией.
	g000ss0179	= {	id = 'g000ss0179', 	race = Race.Dwarf, tier = 1, ban = false }, -- Устрашающий гимн - Уменьшает инициативу отряда на 10%.
	g000ss0021	= {	id = 'g000ss0021', 	race = Race.Dwarf, tier = 1, ban = false }, -- Ледяной щит - Увеличивает броню отряда на 7.
	g000ss0023	= {	id = 'g000ss0023', 	race = Race.Dwarf, tier = 1, ban = false }, -- Сила Витара - Увеличивает урон отряда на 10%.
	g000ss0022	= {	id = 'g000ss0022', 	race = Race.Dwarf, tier = 1, ban = false }, -- Хождение по лесу - Лишает лидера отряда штрафа к передвижению по лесу.
	g000ss0025	= {	id = 'g000ss0025', 	race = Race.Dwarf, tier = 1, ban = false }, -- Призыв I: Рух - Призывает Рух на 1 ход.
	--- Neutral
	g000ss0063	= {	id = 'g000ss0063', 	race = Race.Neutral, tier = 1, ban = true }, -- Дыхание смерти - Уменьшает эффективность заклинаний-благословений отряда на 10%.
	g000ss0191	= {	id = 'g000ss0191', 	race = Race.Neutral, tier = 1, ban = true }, -- Проведение Всевышнего - Лидер отряда получает возможность применять сферы в бою.
	g000ss0192	= {	id = 'g000ss0192', 	race = Race.Neutral, tier = 1, ban = true }, -- Песнь Мимира - Лидер отряда получает возможность применять талисманы в бою.
	g000ss0177	= {	id = 'g000ss0177', 	race = Race.Neutral, tier = 1, ban = true }, -- Откровение - Лидер отряда получает возможность применять посохи и свитки.
	g000ss0188	= {	id = 'g000ss0188', 	race = Race.Neutral, tier = 1, ban = false }, -- Incantare Adipem Diaboli - Призывает Толстого беса на 2 хода.
	--- Elf
	g000ss0097	= {	id = 'g000ss0097', 	race = Race.Elf, tier = 1, ban = false }, -- Кустарник - Наносит отряду 10 урона магией.
	g000ss0101	= {	id = 'g000ss0101', 	race = Race.Elf, tier = 1, ban = false }, -- Стая - Уменьшает урон отряда на 10%.
	g000ss0106	= {	id = 'g000ss0106', 	race = Race.Elf, tier = 1, ban = false }, -- Смятение - Уменьшает инициативу отряда на 10%.
	g000ss0102	= {	id = 'g000ss0102', 	race = Race.Elf, tier = 1, ban = false }, -- Стойкость рощи - Увеличивает ОЗ отряда на 15.
	g000ss0098	= {	id = 'g000ss0098', 	race = Race.Elf, tier = 1, ban = false }, -- Призыв I: Энт Малый - Призывает Энта Малого на 1 ход.
	--- т2
	--- Human
	g000ss0183	= {	id = 'g000ss0183', 	race = Race.Human, tier = 2, ban = false }, -- Сокрушение - Уменьшает броню отряда на 15.
	g000ss0001	= {	id = 'g000ss0001', 	race = Race.Human, tier = 2, ban = false }, -- Защита от магии Воздуха - Дает отряду защиту от Воздуха.
	g000ss0005	= {	id = 'g000ss0005', 	race = Race.Human, tier = 2, ban = false }, -- Защита от магии Воды - Дает отряду защиту от Воды.
	g000ss0016	= {	id = 'g000ss0016', 	race = Race.Human, tier = 2, ban = false }, -- Защита от магии Огня - Дает отряду защиту от Огня.
	g000ss0010	= {	id = 'g000ss0010', 	race = Race.Human, tier = 2, ban = false }, -- Защита от магии Земли - Дает отряду защиту от Земли.
	g000ss0197	= {	id = 'g000ss0197', 	race = Race.Human, tier = 2, ban = false }, -- Заступничество - Воины переднего ряда в отряде получают +25% к шансу принять удар вместо бойца позади себя, если сами не являются целью атаки.
	g000ss0008	= {	id = 'g000ss0008', 	race = Race.Human, tier = 2, ban = false }, -- Призыв I: Живой Доспех - Призывает Оживший доспех на 1 ход.
	--- Undead
	g000ss0067	= {	id = 'g000ss0067', 	race = Race.Undead, tier = 2, ban = false }, -- Чума - Наносит отряду 25 урона магией.
	g000ss0070	= {	id = 'g000ss0070', 	race = Race.Undead, tier = 2, ban = false }, -- Каменный дождь - Наносит отрядам 15 урона магией в области 3х3.
	g000ss0069	= {	id = 'g000ss0069', 	race = Race.Undead, tier = 2, ban = false }, -- Проклятие Ниграэля - Уменьшает урон отряда на 15%.
	g000ss0186	= {	id = 'g000ss0186', 	race = Race.Undead, tier = 2, ban = false }, -- Спешащее время - Увеличивает инициативу отряда на 10% и урон отряда на 5%.
	g000ss0066	= {	id = 'g000ss0066', 	race = Race.Undead, tier = 2, ban = false }, -- Призыв II: Хуорн - Призывает Хуорна на 1 ход.
	g000ss0068	= {	id = 'g000ss0068', 	race = Race.Undead, tier = 2, ban = false }, -- Тень - Закрывает участок карты 9х9.
	--- Heretic
	g000ss0048	= {	id = 'g000ss0048', 	race = Race.Heretic, tier = 2, ban = false }, -- Ignis carn - Наносит отряду 25 урона магией.
	g000ss0049	= {	id = 'g000ss0049', 	race = Race.Heretic, tier = 2, ban = false }, -- Cursa demoneus - Уменьшает урон отряда на 15%.
	g000ss0050	= {	id = 'g000ss0050', 	race = Race.Heretic, tier = 2, ban = false }, -- Chronos - Уменьшает инициативу отряда на 15%.
	g000ss0185	= {	id = 'g000ss0185', 	race = Race.Heretic, tier = 2, ban = false }, -- Terebrare corde - Увеличивает точность и урон отряда на 8%.
	g000ss0180	= {	id = 'g000ss0180', 	race = Race.Heretic, tier = 2, ban = false }, -- Ardenti aqua - Дает отряду защиту от Воды.
	g000ss0046	= {	id = 'g000ss0046', 	race = Race.Heretic, tier = 2, ban = false }, -- Incantare Beliarh - Призывает Белиарха на 1 ход.
	g000ss0047	= {	id = 'g000ss0047', 	race = Race.Heretic, tier = 2, ban = true }, -- Incantare Beliarh Illudere - Призывает фантом Белиарха на 2 хода.
	--- Dwarf
	g000ss0028	= {	id = 'g000ss0028', 	race = Race.Dwarf, tier = 2, ban = false }, -- Ледяной столб - Наносит отряду 25 урона магией.
	g000ss0184	= {	id = 'g000ss0184', 	race = Race.Dwarf, tier = 2, ban = false }, -- Проклятие Имира - Уменьшает урон отряда на 15%.
	g000ss0198	= {	id = 'g000ss0198', 	race = Race.Dwarf, tier = 2, ban = false }, -- Песнь Ансуз - Увеличивает опыт за убийство отряда на 20%.
	g000ss0029	= {	id = 'g000ss0029', 	race = Race.Dwarf, tier = 2, ban = false }, -- Ритуал исцеления - Восстанавливает 40 очков здоровья.
	g000ss0034	= {	id = 'g000ss0034', 	race = Race.Dwarf, tier = 2, ban = false }, -- Заколдованное оружие - Увеличивает точность обеих атак отряда на 10% и дает отряду защиту от Ослабления.
	g000ss0027	= {	id = 'g000ss0027', 	race = Race.Dwarf, tier = 2, ban = false }, -- Мореплавание - Лишает лидера отряда штрафа к передвижению по воде.
	g000ss0030	= {	id = 'g000ss0030', 	race = Race.Dwarf, tier = 2, ban = false }, -- Взгляд Сивиллы - Открывает участок карты 7х7.
	--- Neutral
	g000ss0131	= {	id = 'g000ss0131', 	race = Race.Neutral, tier = 2, ban = true }, -- Ослепительная вcпышка - Уменьшает точность отрядов на 10% в области 7х7.
	g000ss0132	= {	id = 'g000ss0132', 	race = Race.Neutral, tier = 2, ban = true }, -- Вгляд пустоты - Уменьшает точность отрядов на 10% в области 7х7.
	g000ss0133	= {	id = 'g000ss0133', 	race = Race.Neutral, tier = 2, ban = true }, -- Песнь слез - Уменьшает точность отрядов на 10% в области 7х7.
	g000ss0135	= {	id = 'g000ss0135', 	race = Race.Neutral, tier = 2, ban = true }, -- Снежный занавес - Уменьшает точность отрядов на 10% в области 7х7.
	g000ss0189	= {	id = 'g000ss0189', 	race = Race.Neutral, tier = 2, ban = true }, -- Et seminibus discordiae - Уменьшает лидерство на 1 в области 5x5.
	g000ss0300	= {	id = 'g000ss0300', 	race = Race.Neutral, tier = 2, ban = true }, -- Забвение - Лишает лидера отряда возможности использовать свитки, посохи, сферы и талисманы.
	g000ss0121	= {	id = 'g000ss0121', 	race = Race.Neutral, tier = 2, ban = false }, -- Избавление от боли - Восстанавливает 40 очков здоровья.
	g000ss0123	= {	id = 'g000ss0123', 	race = Race.Neutral, tier = 2, ban = false }, -- Заживление ран - Восстанавливает 40 очков здоровья.
	g000ss0124	= {	id = 'g000ss0124', 	race = Race.Neutral, tier = 2, ban = false }, -- Отсрочка неизбежного - Восстанавливает 40 очков здоровья.
	g000ss0176	= {	id = 'g000ss0176', 	race = Race.Neutral, tier = 2, ban = false }, -- Лисья хитрость - Дает лидеру отряда скидку 15%.
	g000ss0146	= {	id = 'g000ss0146', 	race = Race.Neutral, tier = 2, ban = true }, -- Создание горы - Делает клетку непроходимой.
	--- Elf
	g000ss0104	= {	id = 'g000ss0104', 	race = Race.Elf, tier = 2, ban = false }, -- Опаление - Наносит отряду 25 урона магией.
	g000ss0099	= {	id = 'g000ss0099', 	race = Race.Elf, tier = 2, ban = false }, -- Опутывание - Лишает лидера отряда 30% очков передвижения.
	g000ss0182	= {	id = 'g000ss0182', 	race = Race.Elf, tier = 2, ban = false }, -- Спокойствие пламени - Дает отряду защиту от Огня.
	g000ss0187	= {	id = 'g000ss0187', 	race = Race.Elf, tier = 2, ban = false }, -- Могущество - Увеличивает урон отряда на 15%.
	g000ss0103	= {	id = 'g000ss0103', 	race = Race.Elf, tier = 2, ban = false }, -- Призыв II: Энт - Призывает Энта на 1 ход.
	g000ss0100	= {	id = 'g000ss0100', 	race = Race.Elf, tier = 2, ban = false }, -- Скорость - Лидер отряда восстанавливает 15% очков передвижения.
	g000ss0107	= {	id = 'g000ss0107', 	race = Race.Elf, tier = 2, ban = false }, -- Дикие саженцы - Заполняет деревьями область 4х4.
	--- т3
	--- Human
	g000ss0014	= {	id = 'g000ss0014', 	race = Race.Human, tier = 3, ban = false }, -- Гнев Богов - Наносит отряду 40 урона магией.
	g000ss0209	= {	id = 'g000ss0209', 	race = Race.Human, tier = 3, ban = true }, -- Небесный молот - Снижает класс защиты от Воздуха и Разрушения брони отряда.
	g000ss0012	= {	id = 'g000ss0012', 	race = Race.Human, tier = 3, ban = false }, -- Святая броня - Увеличивает броню отряда на 13.
	g000ss0013	= {	id = 'g000ss0013', 	race = Race.Human, tier = 3, ban = false }, -- Святая сила - Увеличивает точность и урон отряда на 15%.
	g000ss0011	= {	id = 'g000ss0011', 	race = Race.Human, tier = 3, ban = false }, -- Защита от магии Разума - Дает отряду защиту от Разума.
	g000ss0018	= {	id = 'g000ss0018', 	race = Race.Human, tier = 3, ban = false }, -- Защита от магии Смерти - Дает отряду защиту от Смерти.
	g000ss0006	= {	id = 'g000ss0006', 	race = Race.Human, tier = 3, ban = false }, -- Ускорение - Лидер отряда восстанавливает 30% очков передвижения.
	--- Undead
	g000ss0072	= {	id = 'g000ss0072', 	race = Race.Undead, tier = 3, ban = false }, -- Драконья порча - Наносит отряду 40 урона магией.
	g000ss0166	= {	id = 'g000ss0166', 	race = Race.Undead, tier = 3, ban = false }, -- Плесень - Уменьшает броню отряда на 22.
	g000ss0205	= {	id = 'g000ss0205', 	race = Race.Undead, tier = 3, ban = true }, -- Прах к праху - Снижает класс защиты от Смерти, Вампиризма и Тауматургии отряда.
	g000ss0073	= {	id = 'g000ss0073', 	race = Race.Undead, tier = 3, ban = false }, -- Прикосновение Мортис - Увеличивает ОЗ отряда на 20%.
	g000ss0071	= {	id = 'g000ss0071', 	race = Race.Undead, tier = 3, ban = false }, -- Призыв III: Кошмар - Призывает Кошмара на 1 ход.
	g000ss0074	= {	id = 'g000ss0074', 	race = Race.Undead, tier = 3, ban = false }, -- Туман Смерти - Закрывает участок карты 15х15.
	--- Heretic
	g000ss0054	= {	id = 'g000ss0054', 	race = Race.Heretic, tier = 3, ban = false }, -- Menta potens - Наносит отряду 40 урона магией.
	g000ss0089	= {	id = 'g000ss0089', 	race = Race.Heretic, tier = 3, ban = false }, -- Preces - Уменьшает точность отряда на 15% и урон отряда на 10%.
	g000ss0206	= {	id = 'g000ss0206', 	race = Race.Heretic, tier = 3, ban = true }, -- Dominatum ignis - Снижает класс защиты от Огня и Ожога отряда.
	g000ss0199	= {	id = 'g000ss0199', 	race = Race.Heretic, tier = 3, ban = true }, -- Terra oblivionem - Уменьшает получаемый отрядами опыт на 25% в области 7х7.
	g000ss0052	= {	id = 'g000ss0052', 	race = Race.Heretic, tier = 3, ban = false }, -- Divis nocte - Закрывает участок карты 15х15.
	g000ss0051	= {	id = 'g000ss0051', 	race = Race.Heretic, tier = 3, ban = true }, -- Sanctuera - Делает отряд невидимым, пока он не вступит в бой.
	--- Dwarf
	g000ss0033	= {	id = 'g000ss0033', 	race = Race.Dwarf, tier = 3, ban = false }, -- Буря - Наносит отряду 40 урона магией.
	g000ss0207	= {	id = 'g000ss0207', 	race = Race.Dwarf, tier = 3, ban = true }, -- Пробирающий холод - Снижает класс защиты от Воды и Обморожения отряда.
	g000ss0026	= {	id = 'g000ss0026', 	race = Race.Dwarf, tier = 3, ban = false }, -- Гимн Кланов - Увеличивает инициативу отряда на 12%.
	g000ss0085	= {	id = 'g000ss0085', 	race = Race.Dwarf, tier = 3, ban = false }, -- Искусный торговец - Дает лидеру отряда скидку 20%.
	g000ss0031	= {	id = 'g000ss0031', 	race = Race.Dwarf, tier = 3, ban = false }, -- Призыв II: Валькирия - Призывает Валькирию на 1 ход.
	--- Neutral
	g000ss0159	= {	id = 'g000ss0159', 	race = Race.Neutral, tier = 3, ban = true }, -- Увечье - Уничтожает 99% очков движения отряда.
	g000ss0190	= {	id = 'g000ss0190', 	race = Race.Neutral, tier = 3, ban = true }, -- Проклятие безволия - Уменьшает лидерство на 1 в области 7x7.
	g000ss0110	= {	id = 'g000ss0110', 	race = Race.Neutral, tier = 3, ban = false }, -- Излечение - Восстанавливает 60 очков здоровья в области 3х3.
	g000ss0149	= {	id = 'g000ss0149', 	race = Race.Neutral, tier = 3, ban = true }, -- Вампиризм - Увеличивает вампиризм отряда на 25%.
	g000ss0150	= {	id = 'g000ss0150', 	race = Race.Neutral, tier = 3, ban = true }, -- Поспешность - Лидер отряда получает возможность быстрого отступления (не действует на воров).
	g000ss0175	= {	id = 'g000ss0175', 	race = Race.Neutral, tier = 3, ban = false }, -- Божественная мудрость - Увеличивает получаемый отрядом опыт на 15%.
	g000ss0200	= {	id = 'g000ss0200', 	race = Race.Neutral, tier = 3, ban = true }, -- Жатва - Увеличивает вампиризм отряда на 25%.
	g000ss0138	= {	id = 'g000ss0138', 	race = Race.Neutral, tier = 3, ban = true }, -- Призыв III: Сущность бури - Призывает Сущность бури на 1 ход.
	g000ss0139	= {	id = 'g000ss0139', 	race = Race.Neutral, tier = 3, ban = true }, -- Призыв III: Ледяная сущность - Призывает Ледяную сущность на 1 ход.
	g000ss0140	= {	id = 'g000ss0140', 	race = Race.Neutral, tier = 3, ban = true }, -- Призыв III: Каменная сущность - Призывает Каменную сущность на 1 ход.
	g000ss0141	= {	id = 'g000ss0141', 	race = Race.Neutral, tier = 3, ban = true }, -- Призыв III: Сущность пламени - Призывает Сущность пламени на 1 ход.
	g000ss0195	= {	id = 'g000ss0195', 	race = Race.Neutral, tier = 3, ban = true }, -- Знамение Хресвельга - Лидер отряда восстанавливает 50% очков передвижения.
	g000ss0144	= {	id = 'g000ss0144', 	race = Race.Neutral, tier = 3, ban = false }, -- Затопление - Заполняет водой область 3х3.
	--- Elf
	g000ss0109	= {	id = 'g000ss0109', 	race = Race.Elf, tier = 3, ban = false }, -- Блуждающий Огонек - Наносит отряду 40 урона магией.
	g000ss0111	= {	id = 'g000ss0111', 	race = Race.Elf, tier = 3, ban = false }, -- Отвлечение - Уменьшает точность отряда на 15% и урон отряда на 10%.
	g000ss0208	= {	id = 'g000ss0208', 	race = Race.Elf, tier = 3, ban = true }, -- Хворь - Снижает класс защиты от Земли и Яда отряда.
	g000ss0125	= {	id = 'g000ss0125', 	race = Race.Elf, tier = 3, ban = false }, -- Источник жизни - Восстанавливает 60 очков здоровья в области 4х4.
	g000ss0201	= {	id = 'g000ss0201', 	race = Race.Elf, tier = 3, ban = false }, -- Неотвратимая месть - Увеличивает критический урон отряда на 12%.
	g000ss0108	= {	id = 'g000ss0108', 	race = Race.Elf, tier = 3, ban = false }, -- Призыв III: Энт Большой - Призывает Энта Большого на 1 ход.
	--- т4
	--- Human
	g000ss0081	= {	id = 'g000ss0081', 	race = Race.Human, tier = 4, ban = false }, -- Цепь молний - Наносит отрядам 40 урона магией в области 5х5.
	g000ss0017	= {	id = 'g000ss0017', 	race = Race.Human, tier = 4, ban = false }, -- Призыв к оружию - Увеличивает урон отряда на 25%.
	g000ss0082	= {	id = 'g000ss0082', 	race = Race.Human, tier = 4, ban = false }, -- Благословение Всевышнего - Увеличивает ОЗ отряда на 20% и броню отряда на 7.
	g000ss0015	= {	id = 'g000ss0015', 	race = Race.Human, tier = 4, ban = true }, -- Призыв II: Голем - Призывает Голема на 1 ход.
	--- Undead
	g000ss0077	= {	id = 'g000ss0077', 	race = Race.Undead, tier = 4, ban = false }, -- Огненное дыхание - Наносит отряду 55 урона магией.
	g000ss0093	= {	id = 'g000ss0093', 	race = Race.Undead, tier = 4, ban = false }, -- Смерч Смерти - Наносит отрядам 40 урона магией в области 5х5.
	g000ss0076	= {	id = 'g000ss0076', 	race = Race.Undead, tier = 4, ban = false }, -- Гниение - Уменьшает урон отряда на 30%.
	g000ss0075	= {	id = 'g000ss0075', 	race = Race.Undead, tier = 4, ban = true }, -- Ужас - Уменьшает инициативу отряда на 27%.
	g000ss0094	= {	id = 'g000ss0094', 	race = Race.Undead, tier = 4, ban = true }, -- Псалом Смерти - Лишает лидеров отрядов 50% очков передвижения в области 4х4.
	--- Heretic
	g000ss0056	= {	id = 'g000ss0056', 	race = Race.Heretic, tier = 4, ban = false }, -- Sinestra ignis - Наносит отряду 55 урона магией.
	g000ss0090	= {	id = 'g000ss0090', 	race = Race.Heretic, tier = 4, ban = false }, -- Potentia Ignis - Наносит отрядам 40 урона магией в области 5х5.
	g000ss0053	= {	id = 'g000ss0053', 	race = Race.Heretic, tier = 4, ban = true }, -- Paraseus - Лишает лидера отряда 100% очков передвижения.
	g000ss0055	= {	id = 'g000ss0055', 	race = Race.Heretic, tier = 4, ban = false }, -- Tortio menta - Уменьшает точность отряда на 30%.
	g000ss0091	= {	id = 'g000ss0091', 	race = Race.Heretic, tier = 4, ban = true }, -- Tempus status - Уменьшает инициативу отряда на 27%.
	g000ss0127	= {	id = 'g000ss0127', 	race = Race.Heretic, tier = 4, ban = true }, -- Merum facies - Снижает класс защиты от Окаменения и Полиморфа отряда.
	--- Dwarf
	g000ss0037	= {	id = 'g000ss0037', 	race = Race.Dwarf, tier = 4, ban = false }, -- Месть Имира - Наносит отряду 55 урона магией.
	g000ss0086	= {	id = 'g000ss0086', 	race = Race.Dwarf, tier = 4, ban = false }, -- Духи льда - Наносит отрядам 40 урона магией в области 5х5.
	g000ss0035	= {	id = 'g000ss0035', 	race = Race.Dwarf, tier = 4, ban = true }, -- Стойкость - Увеличивает броню на отряда на 22.
	g000ss0036	= {	id = 'g000ss0036', 	race = Race.Dwarf, tier = 4, ban = false }, -- Благословение Вотана - Увеличивает урон отряда на 25%.
	g000ss0032	= {	id = 'g000ss0032', 	race = Race.Dwarf, tier = 4, ban = true }, -- Песнь скорости - Лидер отряда восстанавливает 50% очков передвижения.
	--- Neutral
	g000ss0057	= {	id = 'g000ss0057', 	race = Race.Neutral, tier = 4, ban = true }, -- Пламенные небеса - Уменьшает сопротивление ударной магии и эффективность заклинаний-благословений на 30%.
	g000ss0196	= {	id = 'g000ss0196', 	race = Race.Neutral, tier = 4, ban = true }, -- Жестокая вьюга - Лишает лидеров отрядов 50% очков передвижения в области 7х7.
	g000ss0202	= {	id = 'g000ss0202', 	race = Race.Neutral, tier = 4, ban = true }, -- Слабость плоти - Снижает класс защиты от Оружия отряда.
	g000ss0203	= {	id = 'g000ss0203', 	race = Race.Neutral, tier = 4, ban = true }, -- Слабость разума - Снижает класс защиты от Разума отряда.
	g000ss0204	= {	id = 'g000ss0204', 	race = Race.Neutral, tier = 4, ban = true }, -- Подавляющая жизнь - Снижает класс защиты от Жизни отряда.
	g000ss0142	= {	id = 'g000ss0142', 	race = Race.Neutral, tier = 4, ban = true }, -- Призыв IV: Стихийный голем - Призывает Стихийного голема на 1 ход.
	g000ss0158	= {	id = 'g000ss0158', 	race = Race.Neutral, tier = 4, ban = true }, -- Саван Ниграэля - Закрывает участок карты 17х17.
	g000ss0174	= {	id = 'g000ss0174', 	race = Race.Neutral, tier = 4, ban = true }, -- Omnia tenebris - Закрывает карту для врагов.
	g000ss0151	= {	id = 'g000ss0151', 	race = Race.Neutral, tier = 4, ban = true }, -- Освящение земель - Лидер отряда получает возможность устанавливать Жезлы.
	--- Elf
	g000ss0105	= {	id = 'g000ss0105', 	race = Race.Elf, tier = 4, ban = false }, -- Утопление - Наносит отряду 55 урона магией.
	g000ss0112	= {	id = 'g000ss0112', 	race = Race.Elf, tier = 4, ban = false }, -- Лавина - Наносит отрядам 40 урона магией в области 5х5.
	g000ss0115	= {	id = 'g000ss0115', 	race = Race.Elf, tier = 4, ban = false }, -- Проклятие Галеана - Уменьшает урон отряда на 30%.
	g000ss0114	= {	id = 'g000ss0114', 	race = Race.Elf, tier = 4, ban = false }, -- Знак Таладриэль - Увеличивает точность отряда на 25%.
	g000ss0116	= {	id = 'g000ss0116', 	race = Race.Elf, tier = 4, ban = false }, -- Благословение Галеана - Увеличивает ОЗ отряда на 50 и исцеляет отряд на 50 ОЗ.
	--- т5
	--- Human
	g000ss0019	= {	id = 'g000ss0019', 	race = Race.Human, tier = 5, ban = true }, -- Армагеддон - Наносит отряду 70 урона магией.
	g000ss0020	= {	id = 'g000ss0020', 	race = Race.Human, tier = 5, ban = false }, -- Приказ сира Аллемона - Увеличивает точность отряда на 10%, урон отряда на 10% и инициативу отряда на 5%.
	g000ss0083	= {	id = 'g000ss0083', 	race = Race.Human, tier = 5, ban = true }, -- Свет дня - Открывает участок карты 23х23.
	g000ss0084	= {	id = 'g000ss0084', 	race = Race.Human, tier = 5, ban = true }, -- Дар - Лидер отряда получает возможность устанавливать Жезлы.
	--- Undead
	g000ss0080	= {	id = 'g000ss0080', 	race = Race.Undead, tier = 5, ban = true }, -- Истребление - Наносит отряду 70 урона магией.
	g000ss0079	= {	id = 'g000ss0079', 	race = Race.Undead, tier = 5, ban = false }, -- Защита от Оружия - Дает отряду защиту от Оружия.
	g000ss0096	= {	id = 'g000ss0096', 	race = Race.Undead, tier = 5, ban = true }, -- Прикосновение вампира - Увеличивает вампиризм отряда на 35%.
	g000ss0058	= {	id = 'g000ss0058', 	race = Race.Undead, tier = 5, ban = true }, -- Incantare Avenger - Призывает Мстителя на 1 ход.
	g000ss0078	= {	id = 'g000ss0078', 	race = Race.Undead, tier = 5, ban = true }, -- Призыв IV: Танатос - Призывает Танатоса на 1 ход.
	g000ss0095	= {	id = 'g000ss0095', 	race = Race.Undead, tier = 5, ban = true }, -- Сумерки - Закрывает карту для врагов.
	--- Heretic
	g000ss0060	= {	id = 'g000ss0060', 	race = Race.Heretic, tier = 5, ban = true }, -- Deus talonis - Наносит отряду 70 урона магией.
	g000ss0147	= {	id = 'g000ss0147', 	race = Race.Heretic, tier = 5, ban = true }, -- Infernus - Уменьшает критический урон, вампиризм и сопротивление ударной магии отряда на 35%.
	g000ss0059	= {	id = 'g000ss0059', 	race = Race.Heretic, tier = 5, ban = true }, -- Incantare Avenger Illudere - Призывает фантом Мстителя на 2 хода.
	g000ss0092	= {	id = 'g000ss0092', 	race = Race.Heretic, tier = 5, ban = true }, -- Terra Illudere - Делает все отряды невидимыми, пока те не вступят в бой.
	--- Dwarf
	g000ss0040	= {	id = 'g000ss0040', 	race = Race.Dwarf, tier = 5, ban = true }, -- Песнь Вотана - Восстанавливает 100 очков здоровья.
	g000ss0039	= {	id = 'g000ss0039', 	race = Race.Dwarf, tier = 5, ban = false }, -- Неподкупность - Лидер отряда получает навык "Благородство" и +20% неподкупности.
	g000ss0087	= {	id = 'g000ss0087', 	race = Race.Dwarf, tier = 5, ban = true }, -- Ветер путешествий - Лишает все союзные отряды штрафа к передвижению по воде.
	g000ss0088	= {	id = 'g000ss0088', 	race = Race.Dwarf, tier = 5, ban = true }, -- Опыт ветеранов - Увеличивает получаемый отрядом опыт на 15%.
	g000ss0038	= {	id = 'g000ss0038', 	race = Race.Dwarf, tier = 5, ban = true }, -- Призыв III: Каменный предок - Призывает Каменного предка на 1 хо{}
	--- Neutral
	g000ss0210	= {	id = 'g000ss0210', 	race = Race.Neutral, tier = 5, ban = true }, -- Предательство - Лишает лидера отряда навыка "Благородство".
	g000ss0193	= {	id = 'g000ss0193', 	race = Race.Neutral, tier = 5, ban = true }, -- Вознесение - Увеличивает на 20% ОЗ, инициативу и точность, на 30 броню, на 40% крит. удар, лечение и сопротив. ворам, дает защиту от всех стихий.
	g000ss0194	= {	id = 'g000ss0194', 	race = Race.Neutral, tier = 5, ban = true }, -- Божественное благоволение - Увеличивает на 20% ОЗ, инициативу и точность, на 30 броню, на 40% крит. удар, лечение и сопротив. ворам, дает защиту от всех стихий всем отрядам.
	g000ss0136	= {	id = 'g000ss0136', 	race = Race.Neutral, tier = 5, ban = true }, -- Призыв V: Вестник поглощения - Призывает Вестника поглощения на 1 ход.
	g000ss0137	= {	id = 'g000ss0137', 	race = Race.Neutral, tier = 5, ban = true }, -- Призыв V: Вестник немощи - Призывает Вестника немощи на 1 ход.
	g000ss0143	= {	id = 'g000ss0143', 	race = Race.Neutral, tier = 5, ban = true }, -- Призыв V: Вестник перемен - Призывает Вестника перемен на 1 ход.
	g000ss0145	= {	id = 'g000ss0145', 	race = Race.Neutral, tier = 5, ban = false }, -- Потоп - Заполняет водой область 5х5.
	g000ss0148	= {	id = 'g000ss0148', 	race = Race.Neutral, tier = 5, ban = false }, -- Гниение леса - Уничтожает деревья в области 7х7.
	--- Elf
	g000ss0118	= {	id = 'g000ss0118', 	race = Race.Elf, tier = 5, ban = true }, -- Ослепление - Уменьшает точность обеих атак отряда и точность критического удара отряда на 15%.
	g000ss0120	= {	id = 'g000ss0120', 	race = Race.Elf, tier = 5, ban = true }, -- Проворство - Лидер отряда получает возможность быстрого отступления (не действует на воров).
	g000ss0117	= {	id = 'g000ss0117', 	race = Race.Elf, tier = 5, ban = true }, -- Призыв IV: Вердант - Призывает Верданта на 1 ход.
	g000ss0113	= {	id = 'g000ss0113', 	race = Race.Elf, tier = 5, ban = true }, -- Порыв - Лидеры отрядов восстанавливают 20% очков передвижения в области 3х3.
	g000ss0119	= {	id = 'g000ss0119', 	race = Race.Elf, tier = 5, ban = true }, -- Водосточный колодец - Уничтожает указанный Жезл.
}

------------------------------------------------------------------------------------------------------------------------
--- Предметы
local Items = {}
------------------------------------------------------------------------------------------------------------------------
--- Драгоценности
Items.gold = {
	g50 = 'g000ig7001', -- Бронзовое кольцо 50
	g75 = 'g001ig0431', -- Гранат 75
	g100 = 'g000ig7002', -- Серебрянное кольцо 100
	g125 = 'g001ig0432', -- Аметист 125
	g150 = 'g000ig7003', -- Изумруд 150
	g175 = 'g001ig0433', -- Аквамарин 175
	g200 = 'g000ig7004', -- Золотое кольцо 200
	g250 = 'g000ig7005', -- Рубин 250
	g300 = 'g000ig7006', -- Сапфир 300
	g350 = 'g000ig7007', -- Алмаз 350
	g400 = 'g000ig7008', -- Древняя реликвия 400
	g500 = 'g000ig7009', -- Королевский скипетр 500
	g1000 = 'g001ig0090', -- Золотой слиток 1000
}

--- Банки лечения и воскрешения
Items.heal = {
	hres = 'g000ig0001', -- Эликсир жизни 250
	h25 = 'g001ig0180', -- Мешочек трав 50
	h50 = 'g000ig0005', -- Эликсир исцеления 100
	h75 = 'g001ig0378', -- Зелье заживления 150
	h100 = 'g000ig0006', -- Эликсир восстановления 200
	h200 = 'g000ig0018', -- Целебная мазь 350
	h300 = 'g001ig0152', -- Эликсир избавления 500
}

--- Шары маны
Items.mana = {
	all = {
		small = 'g001ig0486', -- Малый шар колдовства 50
		normal = 'g001ig0151', -- Шар колдовства 100
		big = 'g001ig0282', -- Большой шар колдовства 200
	},
	life = {
		small = 'g001ig0481', -- Малый шар маны Жизни 50
		normal = 'g001ig0146', -- Шар маны Жизни 100
		big = 'g001ig0277', -- Большой шар маны Жизни 200
	},
	runic = {
		small = 'g001ig0483', -- Малый шар маны Рун 50
		normal = 'g001ig0148', -- Шар маны Рун 100
		big = 'g001ig0279', -- Большой шар маны Рун 200
	},
	death = {
		small = 'g001ig0484', -- Малый шар маны Смерти 50
		normal = 'g001ig0149', -- Шар маны Смерти 100
		big = 'g001ig0280', -- Большой шар маны Смерти 200
	},
	infernal = {
		small = 'g001ig0482', -- Малый шар маны Ада 50
		normal = 'g001ig0147', -- Шар маны Ада 100
		big = 'g001ig0278', -- Большой шар маны Ада 200
	},
	grove = {
		small = 'g001ig0485', -- Малый шар маны Лесного эликсира 50
		normal = 'g001ig0150', -- Шар маны Лесного эликсира 100
		big = 'g001ig0281', -- Большой шар маны Лесного эликсира 200
	},
}

------------------------------------------------------------------------------------------------------------------------
--- Функции
------------------------------------------------------------------------------------------------------------------------
--- Выбор случайного значения из списка
function rnd(...)
	return (select(math.random(select('#', ...)), ...))
end

--- Выбор случайного значения из таблицы
function rndt(tbl)
	return tbl[math.random(1, #tbl)]
end

--- Изменение порядка значений в таблице
function swap(array, index1, index2)
	array[index1], array[index2] = array[index2], array[index1]
end

--- Перемешивание таблицы
function shake(array)
	local counter = #array

	while counter > 1 do
		local index = math.random(counter)

		swap(array, index, counter)
		counter = counter - 1
	end
end

--- Проверка наличия значения в таблице
function isTableContains(tbl, item)
    for _, v in ipairs(tbl) do
        if v == item then return true end
    end
    return false
end

------------------------------------------------------------------------------------------------------------------------
--- Функции:Соединение зон
------------------------------------------------------------------------------------------------------------------------
function addConn(connections, fromId, toId, size, guard, required)
	local conn = {from = fromId, to = toId, size = size}
	if guard then
		conn.guard = guard
	end
	if required ~= nil then
		conn.required = required
	end
	table.insert(connections, conn)
end

function addPairwise(connections, fromList, toList, size, guardFunc, count, required)
	for _ = 1, count do
		for i = 1, #fromList do
			local guard = guardFunc and guardFunc(fromList[i], toList[i]) or nil
			addConn(connections, fromList[i], toList[i], size, guard, required)
		end
	end
end

function addCartesian(connections, fromList, toList, size, guardFunc, count, required)
	for _ = 1, count do
		for _, fromId in ipairs(fromList) do
			for _, toId in ipairs(toList) do
				local guard = guardFunc and guardFunc(fromId, toId) or nil
				addConn(connections, fromId, toId, size, guard, required)
			end
		end
	end
end
------------------------------------------------------------------------------------------------------------------------
--- Функции:Шаблон
------------------------------------------------------------------------------------------------------------------------
--- Выбор значения в зависимости от режима шаблона
function tmd(var_duo, var_trinity, var_clover)
	if template_mode == duo then
		return var_duo
	elseif template_mode == trinity then
		return var_trinity
	elseif template_mode == clover then
		return var_clover
	end
end

--- Выбор значения в зависимости от режима события
function emd(tbl)
	return tbl[event_mode]
end

--- Подсчет value отряда
function getStackValue(stack, min_value, max_value)
	if not min_value then
		return {}
	end
	if not max_value then
		max_value = min_value
	end
	if not stack.kef then
		stack.kef = kef
	end
	return {min = stack.count * min_value, max = stack.count * max_value * kr * stack.kef}
end

--- Получить список рас за отсутствующих в матче
local function getMissingRaces()
	local missing_races = {}

	for _, race in ipairs(ALL_RACES) do
		local found = false
		for _, present_race in ipairs(Races) do
			if present_race == race then
				found = true
				break
			end
		end

		if not found then
			table.insert(missing_races, race)
		end
	end

	return missing_races
end

--- Получение субрасы в зависимости от рас
function getSubraceByRace(race)
	local list = {
		[Race.Human] = Subrace.Human,
		[Race.Dwarf] = Subrace.Dwarf,
		[Race.Undead] = Subrace.Undead,
		[Race.Heretic] = Subrace.Heretic,
		[Race.Elf] = Subrace.Elf,
	}
	return list[race]
end

--- Cлучайная субраса
function rsub(no_undead)
	local subraces = {
		{Subrace.Human, Subrace.Neutral, Subrace.NeutralHuman, Subrace.NeutralGreenSkin, Subrace.NeutralDragon, Subrace.NeutralMarsh, Subrace.NeutralBarbarian, Subrace.NeutralWolf}, --люди
		{Subrace.Elf, Subrace.Neutral, Subrace.NeutralElf, Subrace.NeutralGreenSkin, Subrace.NeutralDragon, Subrace.NeutralMarsh, Subrace.NeutralBarbarian, Subrace.NeutralWolf}, --эльфы
		{Subrace.Heretic, Subrace.Neutral, Subrace.NeutralGreenSkin, Subrace.NeutralDragon, Subrace.NeutralMarsh, Subrace.NeutralBarbarian, Subrace.NeutralWolf}, --демоны
		{Subrace.Dwarf, Subrace.Neutral, Subrace.NeutralGreenSkin, Subrace.NeutralDragon, Subrace.NeutralMarsh, Subrace.NeutralBarbarian, Subrace.NeutralWolf}, --гномы
	}
	if no_undead then
		for _, v in ipairs(subraces) do
			-- Водные
			table.insert(v, Subrace.NeutralWater)
		end
	else
		-- Нежить
		table.insert(subraces, {Subrace.Undead, Subrace.Neutral, Subrace.NeutralGreenSkin, Subrace.NeutralDragon, Subrace.NeutralMarsh, Subrace.NeutralBarbarian, Subrace.NeutralWolf})
	end
	return rndt(subraces)
end

------------------------------------------------------------------------------------------------------------------------
--- Система распределения данных
------------------------------------------------------------------------------------------------------------------------
local DistributionSystem = {
	requests = {},
	pool_instances = {},
	initialized = false,
	pool_registry = {},
}

-- Типы запросов
local RequestType = {
	ITEMS = "items_data",
	SPELLS = "spells_data",
	TOWN_DATA = "town_data",
	RUIN_DATA = "ruin_data",
	MERCHANT_DATA = "merchant_data",
	MAGE_DATA = "mage_data",
	TRAINER_DATA = "trainer_data",
	MARKET_DATA = "market_data",
	MERCENARY_DATA = "mercenary_data",
	MERCENARY_UNITS = "mercenary_units",
	MINES = "mines",
	LEADERS = "leaders",
	LEADER_MODIFIERS = "leader_modifiers",
	SUBRACES = "subraces",
}

-- Приоритеты распределения
local PoolPriority = {
	AS_POSSIBLE = 1,-- Выдает сколько запрошено, если может
	ALL = 2,        -- Распределяет ВСЕ предметы из пула
	UNLIMITED = 3,  -- Бесконечный пул
}

------------------------------------------------------------------------------------------------------------------------
--- Пулы данных
local Pools = {}
------------------------------------------------------------------------------------------------------------------------
--- Предметы
Pools.items = {
	buff_1 = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = 'g000ig0002', amount = 1, weight = 1 }, -- Эликсир защиты 150
			{ id = 'g000ig0011', amount = 1, weight = 1 }, -- Эликсир ловкости 150
			{ id = 'g000ig0008', amount = 1, weight = 1 }, -- Эликсир меткости 150
			{ id = 'g000ig0014', amount = 1, weight = 1 }, -- Эликсир энергии 150
		}
	},
	buff_2 = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = 'g000ig0003', amount = 1, weight = 1 }, -- Дубовый эликсир 525
			{ id = 'g000ig0012', amount = 1, weight = 1 }, -- Эликсир скорости 425
			{ id = 'g000ig0009', amount = 1, weight = 1 }, -- Эликсир точности 350
			{ id = 'g000ig0015', amount = 1, weight = 1 }, -- Эликсир силы 425
			{ id = 'g002ig0008', amount = 1, weight = 1 }, -- Эликсир скрытого потенциала 350
		}
	},
	buff_e1 = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = 'g001ig0560', amount = 1, weight = 1 }, -- Зелье провокатора 200
			{ id = 'g001ig0547', amount = 1, weight = 1 }, -- Зелье пронзающего взгляда 300
			{ id = 'g001ig0329', amount = 1, weight = 1 }, -- Эликсир защиты от болезней 375
			{ id = 'g001ig0343', amount = 1, weight = 1 }, -- Эликсир защиты от проклятий 375
			{ id = 'g001ig0351', amount = 1, weight = 1 }, -- Эликсир защиты от поглощения 375
		}
	},
	buff_e2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0562', amount = 1, weight = 1 }, -- Зелье дуэлянта 500
			{ id = 'g001ig0491', amount = 1, weight = 1 }, -- Зелье похищения жизни 500
			{ id = 'g001ig0127', amount = 1, weight = 1 }, -- Эликсир жизненной силы 500
			{ id = 'g001ig0355', amount = 1, weight = 1 }, -- Зелье тритоньей чешуи 600
			{ id = 'g001ig0128', amount = 1, weight = 1 }, -- Эликсир защиты от Оружия 400
			{ id = 'g001ig0341', amount = 1, weight = 1 }, -- Эликсир защиты сознания 500
			{ id = 'g002ig0006', amount = 1, weight = 1 }, -- Зелье бдительности 550
			{ id = 'g002ig0008', amount = 1, weight = 1 }, -- Эликсир скрытого потенциала 350
		}
	},
	ward_el = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = 'g000ig0021', amount = 1, weight = 1 }, -- Эликсир защиты от магии Воздуха 250
			{ id = 'g000ig0022', amount = 1, weight = 1 }, -- Эликсир защиты от магии Воды 250
			{ id = 'g000ig0023', amount = 1, weight = 1 }, -- Эликсир защиты от магии Земли 250
			{ id = 'g000ig0024', amount = 1, weight = 1 }, -- Эликсир защиты от магии Огня 250
		}
	},
	ward_1 = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = 'g001ig0125', amount = 1, weight = 1 }, -- Эликсир защиты от магии Разума 250
			{ id = 'g001ig0036', amount = 1, weight = 1 }, -- Эликсир защиты от магии Смерти 250
		}
	},
	ward_2 = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = 'g001ig0128', amount = 1, weight = 1 }, -- Эликсир защиты от Оружия 400
			{ id = 'g001ig0355', amount = 1, weight = 1 }, -- Зелье тритоньей чешуи 600
		}
	},
	ward_dot = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = 'g001ig0329', amount = 1, weight = 1 }, -- Эликсир защиты от болезней 375
			{ id = 'g001ig0341', amount = 1, weight = 1 }, -- Эликсир защиты сознания 375
			{ id = 'g001ig0343', amount = 1, weight = 1 }, -- Эликсир защиты от проклятий 375
			{ id = 'g001ig0351', amount = 1, weight = 1 }, -- Эликсир защиты от поглощения 375
		}
	},
}

------------------------------------------------------------------------------------------------------------------------
-- Шары маны
Pools.items.mana = {
	small = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = Items.mana.life.small, amount = 1, weight = 1 },
			{ id = Items.mana.runic.small, amount = 1, weight = 1 },
			{ id = Items.mana.death.small, amount = 1, weight = 1 },
			{ id = Items.mana.infernal.small, amount = 1, weight = 1 },
			{ id = Items.mana.grove.small, amount = 1, weight = 1 },
		}
	},
	normal = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = Items.mana.life.normal, amount = 1, weight = 1 },
			{ id = Items.mana.runic.normal, amount = 1, weight = 1 },
			{ id = Items.mana.death.normal, amount = 1, weight = 1 },
			{ id = Items.mana.infernal.normal, amount = 1, weight = 1 },
			{ id = Items.mana.grove.normal, amount = 1, weight = 1 },
		}
	},
	big = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = Items.mana.life.big, amount = 1, weight = 1 },
			{ id = Items.mana.runic.big, amount = 1, weight = 1 },
			{ id = Items.mana.death.big, amount = 1, weight = 1 },
			{ id = Items.mana.infernal.big, amount = 1, weight = 1 },
			{ id = Items.mana.grove.big, amount = 1, weight = 1 },
		}
	},
}
-- Родная мана
Pools.items.mana.racial = {
	small = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = Items.mana.life.small, amount = 1, weight = 1, races = {Race.Human} },
			{ id = Items.mana.runic.small, amount = 1, weight = 1, races = {Race.Dwarf} },
			{ id = Items.mana.death.small, amount = 1, weight = 1, races = {Race.Undead} },
			{ id = Items.mana.infernal.small, amount = 1, weight = 1, races = {Race.Heretic} },
			{ id = Items.mana.grove.small, amount = 1, weight = 1, races = {Race.Elf} },
		}
	},
	normal = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = Items.mana.life.normal, amount = 1, weight = 1, races = {Race.Human} },
			{ id = Items.mana.runic.normal, amount = 1, weight = 1, races = {Race.Dwarf} },
			{ id = Items.mana.death.normal, amount = 1, weight = 1, races = {Race.Undead} },
			{ id = Items.mana.infernal.normal, amount = 1, weight = 1, races = {Race.Heretic} },
			{ id = Items.mana.grove.normal, amount = 1, weight = 1, races = {Race.Elf} },
		}
	},
}
-- Специальная мана
Pools.items.mana.special = {
	small = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = Items.mana.life.small, amount = 1, weight = 1, races = {Race.Undead, Race.Heretic} },
			{ id = Items.mana.runic.small, amount = 1, weight = 1, races = {Race.Undead, Race.Heretic, Race.Elf} },
			{ id = Items.mana.death.small, amount = 1, weight = 1, races = {Race.Human, Race.Dwarf, Race.Elf} },
			{ id = Items.mana.infernal.small, amount = 1, weight = 1, races = {Race.Human, Race.Dwarf} },
			{ id = Items.mana.grove.small, amount = 0, weight = 0, races = {} },
		}
	},
	normal = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = Items.mana.life.normal, amount = 1, weight = 1, races = {Race.Undead, Race.Heretic} },
			{ id = Items.mana.runic.normal, amount = 1, weight = 1, races = {Race.Undead, Race.Heretic, Race.Elf} },
			{ id = Items.mana.death.normal, amount = 1, weight = 1, races = {Race.Human, Race.Dwarf, Race.Elf} },
			{ id = Items.mana.infernal.normal, amount = 1, weight = 1, races = {Race.Human, Race.Dwarf} },
			{ id = Items.mana.grove.normal, amount = 0, weight = 0, races = {} },
		}
	},
}

------------------------------------------------------------------------------------------------------------------------
--- Предметы -> Спец.экипировка
Pools.items.special_equip = {
	priority = PoolPriority.AS_POSSIBLE,
	items = {
		{ id = 'g001ig0610', amount = 1, weight = 1 }, -- Оковы долга (Реликвия) 700
		{ id = 'g001ig0539', amount = 1, weight = 1 }, -- Тисовый лук (Реликвия) 900
		{ id = 'g001ig0501', amount = 1, weight = 1 }, -- Дары Галлеана (хождение по лесу) 750
	}
}
--- Предметы -> Сеты
local setItemsConfig = {
	--- Главарь наемников
	['g002ig0001'] = { type = Item.Weapon, ruins = {'t0'}, shops = {'t1'} },        -- Потайной кинжал (Артефакт) 400
	['g002ig0002'] = { type = Item.Jewel,  ruins = {'t1'}, shops = {'t2'} },        -- Промасленная кольчуга (Реликвия) 700
	['g002ig0003'] = { type = Item.Banner,  ruins = {'t3'}, shops = {} },           -- Стяг главаря наемников 1000
	--- Жатва
	['g001ig0602'] = { type = Item.Jewel,  ruins = {'t1'}, shops = {'t2'} },        -- Доспех жатвы (Реликвия) 800
	['g001ig0603'] = { type = Item.Armor,  ruins = {'t2'}, shops = {'t2', 't3'} },  -- Чаша жатвы (Артефакт) 1000
	['g001ig0604'] = { type = Item.Armor, ruins = {'t4', 't5'}, shops = {'t3'} },   -- Кинжал жатвы (Артефакт) 1900
	--- Наследие Феникса
	['g002ig0010'] = { type = Item.Weapon, ruins = {'t3'}, shops = {'t3'} },        -- Меч рыцаря Феникса (Артефакт) 1750
	['g002ig0011'] = { type = Item.Armor,  ruins = {'t3'}, shops = {'t3'} },        -- Щит рыцаря Феникса (Артефакт) 1500
	['g002ig0012'] = { type = Item.Jewel,  ruins = {'t4', 't5'}, shops = {'t3'} },  -- Доспех рыцаря Феникса (Реликвия) 2100
	--- Кодекс крови
	['g002ig0013'] = { type = Item.Weapon, ruins = {'t4', 't5'}, shops = {'t3'} },  -- Серп Кровавого Ворона (Артефакт) 1850
	['g002ig0014'] = { type = Item.Weapon, ruins = {'t3'}, shops = {'t3'} },        -- Кама Кровавого Ворона (Артефакт) 1600
	['g002ig0015'] = { type = Item.Jewel,  ruins = {'t3'}, shops = {'t3'} },        -- Кираса Кровавого Ворона (Реликвия) 2100
	['g002ig0016'] = { type = Item.Banner, ruins = {'t4', 't5'}, shops = {'t3'} },  -- Стяг Кровавого Ворона 2250+
}

function tryPlaceSetItem(ruin, setItemId, expectedType, chance)
    local config = setItemsConfig[setItemId]
    if not config then return false end
    if expectedType and config.type ~= expectedType then return false end
    if setItemsStatus[setItemId] then return false end
    if math.random() < chance then
        setItemsStatus[setItemId] = true
        ruin.loot.items = ruin.loot.items or {}
        table.insert(ruin.loot.items, { id = setItemId, min = 1, max = 1 })
        return true
    end
    return false
end

------------------------------------------------------------------------------------------------------------------------
--- Предметы -> Столица
Pools.capital = {
	-- Фиксированные предметы
	fix_perk = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = 'g001ig0530', amount = 1, weight = 1 }, -- Зелье посмертного зова 500
		}
	},
	fix_heal = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = Items.heal.h25, amount = 1, weight = 1, group_amount = 7 },
			{ id = Items.heal.h50, amount = 1, weight = 1, group_amount = 6 },
			{ id = Items.heal.h75, amount = 1, weight = 1, group_amount = 5 },
			{ id = Items.heal.h100, amount = 1, weight = 1, group_amount = 4 },
			{ id = Items.heal.hres, amount = 1, weight = 1, group_amount = 3 },
		}
	},
	fix_buff_1 = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = 'g000ig0008', amount = 1, weight = 1, group_amount = 3 }, -- Эликсир меткости 150
			{ id = 'g000ig0002', amount = 1, weight = 1, group_amount = 1 }, -- Эликсир защиты 150
			{ id = 'g000ig0014', amount = 1, weight = 1, group_amount = 1 }, -- Эликсир энергии 150
			{ id = 'g000ig0011', amount = 1, weight = 1, group_amount = 1 }, -- Эликсир ловкости 150
		}
	},
	fix_ward_1 = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = 'g001ig0036', amount = 1, weight = 1 }, -- Эликсир защиты от магии Смерти 250
			{ id = 'g001ig0125', amount = 1, weight = 1 }, -- Эликсир защиты от магии Разума 250
			{ id = 'g001ig0128', amount = 1, weight = 1 }, -- Эликсир защиты от Оружия 400
		}
	},
	fix_ward_el = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = 'g000ig0021', amount = 1, weight = 1 }, -- Эликсир защиты от магии Воздуха 250
			{ id = 'g000ig0022', amount = 1, weight = 1 }, -- Эликсир защиты от магии Воды 250
			{ id = 'g000ig0023', amount = 1, weight = 1 }, -- Эликсир защиты от магии Земли 250
			{ id = 'g000ig0024', amount = 1, weight = 1 }, -- Эликсир защиты от магии Огня 250
		}
	},
	-- случайные предметы
	rnd_buff_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig0008', amount = 1, weight = 1 }, -- Эликсир меткости 150
			{ id = 'g000ig0002', amount = 1, weight = 1 }, -- Эликсир защиты 150
			{ id = 'g000ig0014', amount = 1, weight = 1 }, -- Эликсир энергии 150
			{ id = 'g000ig0011', amount = 1, weight = 1 }, -- Эликсир ловкости 150
		}
	},
	rnd_ward_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0125', amount = 1, weight = 1 }, -- Эликсир защиты от магии Разума 250
			{ id = 'g001ig0036', amount = 1, weight = 1 }, -- Эликсир защиты от магии Смерти 250
		}
	},
	rnd_ward_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0128', amount = 1, weight = 1 }, -- Эликсир защиты от Оружия 400
			{ id = 'g001ig0355', amount = 1, weight = 1 }, -- Зелье тритоньей чешуи 600
		}
	},
	ward_dot = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0329', amount = 1, weight = 1 }, -- Эликсир защиты от болезней 375
			{ id = 'g001ig0341', amount = 1, weight = 1 }, -- Эликсир защиты сознания 375
			{ id = 'g001ig0343', amount = 1, weight = 1 }, -- Эликсир защиты от проклятий 375
			{ id = 'g001ig0351', amount = 1, weight = 1 }, -- Эликсир защиты от поглощения 375
		}
	},
	rnd_ward_el = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig0021', amount = 1, weight = 1 }, -- Эликсир защиты от магии Воздуха 250
			{ id = 'g000ig0022', amount = 1, weight = 1 }, -- Эликсир защиты от магии Воды 250
			{ id = 'g000ig0023', amount = 1, weight = 1 }, -- Эликсир защиты от магии Земли 250
			{ id = 'g000ig0024', amount = 1, weight = 1 }, -- Эликсир защиты от магии Огня 250
		}
	},
	rnd_sphere_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0458', amount = 1, weight = 1 }, -- Сфера Каменного проклятия 100
			{ id = 'g000ig9031', amount = 1, weight = 1 }, -- Сфера Ливня 100
			{ id = 'g000ig9022', amount = 1, weight = 1 }, -- Сфера Углей 100
			{ id = 'g001ig0302', amount = 1, weight = 1 }, -- Сфера Шторма 100
		}
	},
	rnd_sphere_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0189', amount = 1, weight = 1 }, -- Сфера Камня 100
			{ id = 'g001ig0178', amount = 1, weight = 1 }, -- Сфера Костра 100
			{ id = 'g001ig0472', amount = 1, weight = 1 }, -- Сфера Ледяного осколка 100
			{ id = 'g001ig0473', amount = 1, weight = 1 }, -- Сфера Статического разряда 100
		}
	},
	rnd_scrolls_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5021', amount = 1, weight = 1 }, -- Свиток "Ледяной щит" 200
			{ id = 'g000ig5003', amount = 1, weight = 1 }, -- Свиток "Сила" 200
			{ id = 'g001ig0250', amount = 1, weight = 1 }, -- Свиток "Стальные кости" 200
			{ id = 'g000ig5023', amount = 1, weight = 1 }, -- Свиток "Сила Витара" 200
		}
	},
	rnd_scrolls_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0248', amount = 1, weight = 1 }, -- Свиток "Устрашающий гимн" 200
			{ id = 'g000ig5045', amount = 1, weight = 1 }, -- Свиток "Tormentio" 200
			{ id = 'g000ig5064', amount = 1, weight = 1 }, -- Свиток "Слабость" 200
			{ id = 'g000ig5101', amount = 1, weight = 1 }, -- Свиток "Стая" 200
		}
	},
	rnd_bonus = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0532', amount = 1, weight = 1 }, -- Зелье дозорного 200
			{ id = 'g000ig5009', amount = 1, weight = 1 }, -- Свиток "Истинное зрение" 200
			{ id = 'g000ig5041', amount = 1, weight = 1 }, -- Свиток "Incantare Hellhound" 200
			{ id = 'g001ig0006', amount = 1, weight = 1 }, -- Эликсир маскировки 400
			{ id = 'g001ig0130', amount = 1, weight = 1 }, -- Эликсир регенерации 400
		}
	},
	rnd_equip = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig2001', amount = 3, weight = 1, type = Item.Armor }, -- Рунный камень 300
			{ id = 'g000ig3001', amount = 3, weight = 1, type = Item.Weapon }, -- Гномьи наручи 300
			{ id = 'g001ig0100', amount = 3, weight = 1, type = Item.Weapon }, -- Цепь Хана 300
			{ id = 'g001ig0101', amount = 2, weight = 1, type = Item.Jewel }, -- Череп Хана 350
			{ id = 'g001ig0105', amount = 1, weight = 1, type = Item.Travel }, -- Литейные сапоги 300
			{ id = 'g001ig0106', amount = 1, weight = 1, type = Item.Travel }, -- Сапоги каменщика 300
			{ id = 'g001ig0107', amount = 1, weight = 1, type = Item.Travel }, -- Сапоги ветров 300
			{ id = 'g001ig0108', amount = 1, weight = 1, type = Item.Travel }, -- Гномьи сапоги 300
			{ id = 'g001ig0109', amount = 1, weight = 1, type = Item.Travel }, -- Сапоги жизни 300
			{ id = 'g001ig0110', amount = 1, weight = 1, type = Item.Travel }, -- Легкие сапоги 300
			{ id = 'g001ig0113', amount = 1, weight = 1, type = Item.Travel }, -- Укрепленные сапоги 300
		}
	},
}

------------------------------------------------------------------------------------------------------------------------
--- Предметы -> Торговцы
Pools.goods = {}

------------------------------------------------------------------------------------------------------------------------
--- Лавка т1
Pools.goods.t1 = {
	heal = {
		priority = PoolPriority.ALL,
		items = {
			{ id = Items.heal.hres, amount = 4, weight = 1 },
			{ id = Items.heal.h100, amount = 5, weight = 1 },
			{ id = Items.heal.h75, amount = 6, weight = 1 },
			{ id = Items.heal.h50, amount = 7, weight = 1 },
			{ id = Items.heal.h25, amount = 8, weight = 1 },
		}
	},
	permo_stat_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0533', amount = 1, weight = 1 }, -- Зелье ясного взора 400
			{ id = 'g001ig0006', amount = 1, weight = 1 }, -- Эликсир маскировки 400
		}
	},
	permo_stat_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0027', amount = 1, weight = 1 }, -- Аура брони 700
			{ id = 'g000ig0013', amount = 1, weight = 1 }, -- Эликсир неуловимости 650
		}
	},
	permo_stat_3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0130', amount = 1, weight = 1 }, -- Эликсир регенерации 400
			{ id = 'g001ig0561', amount = 1, weight = 1 }, -- Эликсир самопожертвования 600
		}
	},
	artifact_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0611', amount = 1, weight = 1 }, -- Цепи жертвенности (Артефакт) 300
			{ id = 'g001ig0048', amount = 1, weight = 1 }, -- Амулет Кракена (Артефакт) 375
			{ id = 'g001ig0609', amount = 1, weight = 1 }, -- Загробный фонарь (Артефакт) 400
			{ id = 'g001ig0418', amount = 1, weight = 1 }, -- Руна защиты Фрейра (Артефакт) 400
			{ id = 'g000ig2002', amount = 1, weight = 1 }, -- Святая чаша (Артефакт) 500
			{ id = 'g001ig0182', amount = 1, weight = 1 }, -- Счастливая кость (Артефакт) 500

		}
	},
	artifact_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig3017', amount = 1, weight = 1 }, -- Кинжал Вампиризма (Артефакт) 550
			{ id = 'g000ig3002', amount = 1, weight = 1 }, -- Дьявольская чаша (Артефакт) 650
			{ id = 'g001ig0559', amount = 1, weight = 1 }, -- Руна благоволения Тиу (Артефакт) 700
			{ id = 'g001ig0557', amount = 1, weight = 1 }, -- Рог непреклонности (Артефакт) 700
			{ id = 'g001ig0558', amount = 1, weight = 1 }, -- Рог возмездия (Артефакт) 700
			{ id = 'g001ig0594', amount = 1, weight = 1 }, -- Щит телохранителя (Артефакт) 700
			{ id = 'g001ig0487', amount = 1, weight = 1 }, -- Кольцо темных искуств (Артефакт) 800
		}
	},
	relic_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0421', amount = 1, weight = 1 }, -- Борода Имира (Реликвия) 500
			{ id = 'g001ig0426', amount = 1, weight = 1 }, -- Куртка капитана (Реликвия) 400
			{ id = 'g001ig0104', amount = 1, weight = 1 }, -- Зуб людоеда (Реликвия) 800
			{ id = 'g000ig3022', amount = 1, weight = 1 }, -- Лютня Очарования (Реликвия) 650
			{ id = 'g001ig0605', amount = 1, weight = 1 }, -- Книга постижения 600
			{ id = 'g000ig3020', amount = 1, weight = 1 }, -- Череп Танатоса (Реликвия) 500
			{ id = 'g001ig0099', amount = 1, weight = 1 }, -- Перчатки дуэлянта (Реликвия) 500
			{ id = 'g000ig4007', amount = 1, weight = 1 }, -- Медицинский трактат 500
		}
	},
	relic_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig4001', amount = 1, weight = 1 }, -- Книга воздуха 500
			{ id = 'g000ig4002', amount = 1, weight = 1 }, -- Книга воды 500
			{ id = 'g000ig4003', amount = 1, weight = 1 }, -- Книга земли 500
			{ id = 'g000ig4004', amount = 1, weight = 1 }, -- Книга Огня 500
		}
	},
	relic_3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0497', amount = 1, weight = 1 }, -- Книга колдовства 400
		}
	},
	boots_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0105', amount = 1, weight = 1 }, -- Литейные сапоги 300
			{ id = 'g001ig0106', amount = 1, weight = 1 }, -- Сапоги каменщика 300
			{ id = 'g001ig0107', amount = 1, weight = 1 }, -- Сапоги ветров 300
			{ id = 'g001ig0108', amount = 1, weight = 1 }, -- Гномьи сапоги 300
		}
	},
	boots_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0110', amount = 1, weight = 1 }, -- Легкие сапоги 300
			{ id = 'g001ig0113', amount = 1, weight = 1 }, -- Укрепленные сапоги 300
			{ id = 'g002ig0022', amount = 1, weight = 1 }, -- Ботинки исследователя 500
		}
	},
	banner = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0051', amount = 1, weight = 1 }, -- Знамя выносливости 400
			{ id = 'g000ig1007', amount = 1, weight = 1 }, -- Знамя силы 400
			{ id = 'g000ig1003', amount = 1, weight = 1 }, -- Знамя сражения 400
			{ id = 'g000ig1001', amount = 1, weight = 1 }, -- Знамя защиты 500
			{ id = 'g000ig1005', amount = 1, weight = 1 }, -- Знамя быстроты 550
			{ id = 'g001ig0370', amount = 1, weight = 1 }, -- Знамя искоренителя ереси 600
			{ id = 'g001ig0369', amount = 1, weight = 1 }, -- Знамя снежной охоты 600
		}
	},
	sphere_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0458', amount = 1, weight = 1 }, -- Сфера Каменного проклятия 100
			{ id = 'g000ig9031', amount = 1, weight = 1 }, -- Сфера Ливня 100
			{ id = 'g000ig9022', amount = 1, weight = 1 }, -- Сфера Углей 100
			{ id = 'g001ig0302', amount = 1, weight = 1 }, -- Сфера Шторма 100
			{ id = 'g001ig0189', amount = 1, weight = 1 }, -- Сфера Камня 100
			{ id = 'g001ig0178', amount = 1, weight = 1 }, -- Сфера Костра 100
			{ id = 'g001ig0472', amount = 1, weight = 1 }, -- Сфера Ледяного осколка 100
			{ id = 'g001ig0473', amount = 1, weight = 1 }, -- Сфера Статического разряда 100
			{ id = 'g001ig0470', amount = 1, weight = 1 }, -- Сфера Подавления 100
			{ id = 'g001ig0192', amount = 1, weight = 1 }, -- Сфера Пыток 100
			{ id = 'g000ig9033', amount = 1, weight = 1 }, -- Сфера Чумы 100
		}
	},
	sphere_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0133', amount = 1, weight = 1 }, -- Сфера Брони I 200
			{ id = 'g001ig0446', amount = 1, weight = 1 }, -- Сфера Вампиризма I 200
			{ id = 'g000ig9017', amount = 1, weight = 1 }, -- Сфера Восстановления 200
			{ id = 'g001ig0471', amount = 1, weight = 1 }, -- Сфера Охотника 200
			{ id = 'g001ig0464', amount = 1, weight = 1 }, -- Сфера Разрушения доспеха I 200
			{ id = 'g001ig0450', amount = 1, weight = 1 }, -- Сфера Урона I 200
		}
	},
	talisman = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0184', amount = 1, weight = 1 }, -- Талисман восстановления 400
			{ id = 'g000ig9109', amount = 1, weight = 1 }, -- Талисман души солдата 450
			{ id = 'g000ig9120', amount = 1, weight = 1 }, -- Талисман щита стихий 500
		}
	},
	staff_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0402', amount = 1, weight = 1 }, -- Посох отлучения 200
			{ id = 'g001ig0387', amount = 1, weight = 1 }, -- Посох следопыта 200
			{ id = 'g000ig6001', amount = 1, weight = 1 }, -- Посох грома 200
			{ id = 'g000ig6003', amount = 1, weight = 1 }, -- Посох святости 200
		}
	},
	staff_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0394', amount = 1, weight = 1 }, -- Посох северных стражей 200
			{ id = 'g001ig0395', amount = 1, weight = 1 }, -- Посох наместника Махаля 200
			{ id = 'g001ig0399', amount = 1, weight = 1 }, -- Посох раздора 200
			{ id = 'g000ig6012', amount = 1, weight = 1 }, -- Посох скорости 200
		}
	},
	staff_summon = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0383', amount = 1, weight = 1, races = {Race.Human, Race.Dwarf, Race.Heretic, Race.Undead} }, -- Посох первых побегов 200
			{ id = 'g001ig0384', amount = 1, weight = 1, races = {Race.Human, Race.Dwarf, Race.Undead, Race.Elf} }, -- Посох демонической охоты 200
			{ id = 'g001ig0385', amount = 1, weight = 1, races = {Race.Human, Race.Dwarf, Race.Undead, Race.Elf} }, -- Посох мании 200
			{ id = 'g000ig6002', amount = 1, weight = 1, races = {Race.Human, Race.Dwarf, Race.Heretic, Race.Elf} }, -- Посох некроманта 200
		}
	},
	scrolls_1_buff = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5003', amount = 1, weight = 1 }, -- Свиток "Сила" 200
			{ id = 'g000ig5021', amount = 1, weight = 1 }, -- Свиток "Ледяной щит" 200
			{ id = 'g000ig5023', amount = 1, weight = 1 }, -- Свиток "Сила Витара" 200
			{ id = 'g001ig0250', amount = 1, weight = 1 }, -- Свиток "Стальные кости" 200
		}
	},
	scrolls_1_debuff = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5045', amount = 1, weight = 1 }, -- Свиток "Tormentio" 200
			{ id = 'g000ig5064', amount = 1, weight = 1 }, -- Свиток "Слабость" 200
			{ id = 'g000ig5101', amount = 1, weight = 1 }, -- Свиток "Стая" 200
			{ id = 'g001ig0248', amount = 1, weight = 1 }, -- Свиток "Устрашающий гимн" 200
		}
	},
	scrolls_heal = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5007', amount = 1, weight = 1 }, -- Свиток "Исцеление" 200
			{ id = 'g000ig5029', amount = 1, weight = 1 }, -- Свиток "Ритуал исцеления" 400
		}
	},
	scrolls_ward = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5005', amount = 1, weight = 1 }, -- Свиток "Защита от магии Воды" 400
			{ id = 'g000ig5001', amount = 1, weight = 1 }, -- Свиток "Защита от магии Воздуха" 400
			{ id = 'g000ig5010', amount = 1, weight = 1 }, -- Свиток "Защита от магии Земли" 400
			{ id = 'g000ig5016', amount = 1, weight = 1 }, -- Свиток "Защита от магии Огня" 400
		}
	},
	scrolls_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0249', amount = 0, weight = 1 }, -- Свиток "Ardenti aqua" 400
			{ id = 'g000ig5050', amount = 1, weight = 1 }, -- Свиток "Chronos" 400
			{ id = 'g000ig5049', amount = 1, weight = 1 }, -- Свиток "Cursa demoneus" 400
			{ id = 'g000ig5048', amount = 1, weight = 1 }, -- Свиток "Ingis carn" 400
			{ id = 'g000ig5047', amount = 0, weight = 1 }, -- Свиток "Incantare Beliarh Illudere" 400
			{ id = 'g000ig5046', amount = 0, weight = 1 }, -- Свиток "Incantare Beliarh" 400
			{ id = 'g001ig0164', amount = 1, weight = 1 }, -- Свиток "Infernus" 400
			{ id = 'g001ig0254', amount = 1, weight = 1 }, -- Свиток "Terebrare corde" 400
			{ id = 'g001ig0193', amount = 1, weight = 1 }, -- Свиток "Божественная мудрость" 400
			{ id = 'g001ig0093', amount = 1, weight = 1 }, -- Свиток "Вампиризм" 400
			{ id = 'g000ig5030', amount = 1, weight = 1 }, -- Свиток "Взгляд Сивиллы" 400
			{ id = 'g001ig0091', amount = 0, weight = 1 }, -- Свиток "Гниение леса" 400
			{ id = 'g001ig0571', amount = 1, weight = 1 }, -- Свиток "Жатва" 400
			{ id = 'g002ig0023', amount = 1, weight = 1 }, -- Свиток "Забвение" 400
			{ id = 'g000ig5034', amount = 1, weight = 1 }, -- Свиток "Заговоренное оружие" 400
			{ id = 'g001ig0568', amount = 1, weight = 1 }, -- Свиток "Заступничество" 400
			{ id = 'g000ig5070', amount = 1, weight = 1 }, -- Свиток "Каменный дождь" 400
			{ id = 'g000ig5028', amount = 1, weight = 1 }, -- Свиток "Ледяной столб" 400
			{ id = 'g001ig0256', amount = 1, weight = 1 }, -- Свиток "Могущество" 400
			{ id = 'g000ig5027', amount = 0, weight = 1 }, -- Свиток "Мореплавание" 400
			{ id = 'g000ig5104', amount = 1, weight = 1 }, -- Свиток "Опаление" 400
			{ id = 'g000ig5099', amount = 0, weight = 1 }, -- Свиток "Опутывание" 400
			{ id = 'g000ig5088', amount = 1, weight = 1 }, -- Свиток "Опыт ветеранов" 400
			{ id = 'g000ig5118', amount = 1, weight = 1 }, -- Свиток "Ослепления" 400
			{ id = 'g001ig0569', amount = 1, weight = 1 }, -- Свиток "Песнь Ансуз" 400
			{ id = 'g000ig5020', amount = 1, weight = 1 }, -- Свиток "Приказ Сира Аллемона" 400
			{ id = 'g001ig0253', amount = 1, weight = 1 }, -- Свиток "Проклятие Имира" 400
			{ id = 'g000ig5069', amount = 1, weight = 1 }, -- Свиток "Проклятие Ниграэля" 400
			{ id = 'g000ig5029', amount = 0, weight = 1 }, -- Свиток "Ритуал исцеления" 400
			{ id = 'g001ig0123', amount = 1, weight = 1 }, -- Свиток "Саван Ниграэля" 400
			{ id = 'g000ig5107', amount = 0, weight = 1 }, -- Свиток "Создание Рощи" 400
			{ id = 'g001ig0255', amount = 1, weight = 1 }, -- Свиток "Спешащее время" 400
			{ id = 'g001ig0251', amount = 0, weight = 1 }, -- Свиток "Спокойствие пламени" 400
			{ id = 'g000ig5068', amount = 0, weight = 1 }, -- Свиток "Тень" 400
			{ id = 'g000ig5067', amount = 1, weight = 1 }, -- Свиток "Чума" 400
		}
	},
	scrolls_3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5084', amount = 1, weight = 1 }, -- Свиток "Дар" 200
		}
	},
}
--- Лавка т2
Pools.goods.t2 = {
	heal = {
		priority = PoolPriority.ALL,
		items = {
			{ id = Items.heal.hres, amount = 5, weight = 1 },
			{ id = Items.heal.h100, amount = 6, weight = 1 },
			{ id = Items.heal.h75, amount = 7, weight = 1 },
			{ id = Items.heal.h50, amount = 8, weight = 1 },
			{ id = Items.heal.h25, amount = 9, weight = 1 },
		}
	},
	buff_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g002ig0007', amount = 2, weight = 1 }, -- Зелье магической устойчивости 250
			{ id = 'g002ig0005', amount = 2, weight = 1 }, -- Зелье наблюдательности 350
			{ id = 'g002ig0006', amount = 1, weight = 1 }, -- Зелье бдительности 550
		}
	},
	permo_stat_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0534', amount = 1, weight = 1 }, -- Экстракт таинственной энергии 700
		}
	},
	permo_stat_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig0004', amount = 1, weight = 1 }, -- Эликсир твердости 730
			{ id = 'g001ig0028', amount = 1, weight = 1 }, -- Аура выносливости 700
		}
	},
	permo_stat_3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig0016', amount = 1, weight = 1 }, -- Эликсир мощи 625
			{ id = 'g001ig0029', amount = 1, weight = 1 }, -- Аура силы 600
		}
	},
	artifact = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0417', amount = 1, weight = 1 }, -- Руна верности Моккуркальфи (Артефакт) 800
			{ id = 'g001ig0045', amount = 1, weight = 1 }, -- Кровь святого (Артефакт) 800
			{ id = 'g000ig3003', amount = 1, weight = 1 }, -- Кольцо силы (Артефакт) 800
			{ id = 'g001ig0042', amount = 1, weight = 1 }, -- Клыки Бездны (Артефакт) 950
			{ id = 'g001ig0047', amount = 1, weight = 1 }, -- Руна Жизни (Артефакт) 800
			{ id = 'g001ig0196', amount = 1, weight = 1 }, -- Рунный молот (Артефакт) 725
			{ id = 'g001ig0582', amount = 1, weight = 1 }, -- Камень врат (Артефакт) 600
			{ id = 'g001ig0416', amount = 1, weight = 1 }, -- Руна предвидения Вотана (Артефакт) 800
			{ id = 'g001ig0589', amount = 1, weight = 1 }, -- Щит неведения (Артефакт) 800
			{ id = 'g001ig0040', amount = 1, weight = 1 }, -- Перстень песков (Артефакт) 1000
			{ id = 'g001ig0657', amount = 1, weight = 1 }, -- Топор палача (Артефакт) 1000
		}
	},
	relic_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0420', amount = 1, weight = 1 }, -- Вечные латы (Реликвия) 800
			{ id = 'g001ig0424', amount = 1, weight = 1 }, -- Длани ангела (Реликвия) 1000
			{ id = 'g001ig0422', amount = 1, weight = 1 }, -- Кровавый покров (Реликвия) 700
			{ id = 'g000ig2006', amount = 1, weight = 1 }, -- Тиара чистоты (Реликвия) 800
			{ id = 'g001ig0427', amount = 1, weight = 1 }, -- Нагрудник Стража (Реликвия)
			{ id = 'g001ig0423', amount = 1, weight = 1 }, -- Латы Спасителя (Реликвия) 700
			{ id = 'g001ig0156', amount = 1, weight = 1 }, -- Шкатулка предсказаний (Реликвия) 1050
		}
	},
	relic_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0493', amount = 1, weight = 1 }, -- Книга божественных даров 400
			{ id = 'g001ig0494', amount = 1, weight = 1 }, -- Книга странника 400
			{ id = 'g001ig0495', amount = 1, weight = 1 }, -- Книга наследия 400
		}
	},
	banner_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0142', amount = 1, weight = 1 }, -- Знамя магии Воды 700
			{ id = 'g001ig0140', amount = 1, weight = 1 }, -- Знамя магии Воздуха 700
			{ id = 'g001ig0141', amount = 1, weight = 1 }, -- Знамя магии Земли 700
			{ id = 'g001ig0139', amount = 1, weight = 1 }, -- Знамя магии Огня 700
		}
	},
	banner_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0293', amount = 1, weight = 1 }, -- Баннер неудержимых 775
			{ id = 'g000ig1004', amount = 1, weight = 1 }, -- Знамя битвы 700
			{ id = 'g001ig0361', amount = 1, weight = 1 }, -- Знамя горна 700
			{ id = 'g001ig0289', amount = 1, weight = 1 }, -- Знамя городских стражей 700
			{ id = 'g001ig0363', amount = 1, weight = 1 }, -- Знамя отваги 750
			{ id = 'g000ig1008', amount = 1, weight = 1 }, -- Знамя энергии 700
			{ id = 'g001ig0292', amount = 1, weight = 1 }, -- Стяг концентрации 700
			{ id = 'g001ig0367', amount = 1, weight = 1 }, -- Стяг чумных воинств 700
		}
	},
	boots_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0111', amount = 1, weight = 1 }, -- Сапоги ассасина 650
			{ id = 'g001ig0114', amount = 1, weight = 1 }, -- Тяжелые сапоги 500
			{ id = 'g002ig0022', amount = 1, weight = 1 }, -- Ботинки исследователя 500
		}
	},
	boots_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0112', amount = 1, weight = 1 }, -- Крылья ангела 1200
			{ id = 'g001ig0115', amount = 1, weight = 1 }, -- Железная поступь 1100
		}
	},
	talisman = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0259', amount = 1, weight = 1 }, -- Талисман души хитреца 600
			{ id = 'g000ig9128', amount = 1, weight = 1 }, -- Талисман молнии 800
			{ id = 'g001ig0063', amount = 1, weight = 1 }, -- Талисман прилива 800
			{ id = 'g000ig9116', amount = 1, weight = 1 }, -- Талисман святой земли 800
			{ id = 'g000ig9124', amount = 1, weight = 1 }, -- Талисман мрака 1000
		}
	},
	sphere_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0056', amount = 1, weight = 1 }, -- Сфера защиты от магии Воды 400
			{ id = 'g001ig0054', amount = 1, weight = 1 }, -- Сфера защиты от магии Воздуха 400
			{ id = 'g001ig0055', amount = 1, weight = 1 }, -- Сфера защиты от магии Земли 400
			{ id = 'g001ig0053', amount = 1, weight = 1 }, -- Сфера защиты от магии Огня 400
		}
	},
	sphere_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0058', amount = 1, weight = 1 }, -- Сфера защиты от магии Разума 400
			{ id = 'g001ig0057', amount = 1, weight = 1 }, -- Сфера защиты от магии Смерти 400
			{ id = 'g001ig0187', amount = 1, weight = 1 }, -- Сфера Пламени 400
			{ id = 'g001ig0453', amount = 1, weight = 1 }, -- Сфера Святой земли 400
			{ id = 'g001ig0176', amount = 1, weight = 1 }, -- Сфера Вампиризма II 400
			{ id = 'g001ig0456', amount = 1, weight = 1 }, -- Сфера Прилива 400
			{ id = 'g001ig0496', amount = 1, weight = 1 }, -- Сфера Мучений 400
			{ id = 'g000ig9042', amount = 1, weight = 1 }, -- Сфера направленного ослабления I 400
			{ id = 'g001ig0475', amount = 1, weight = 1 }, -- Сфера Обширной коррозии I 400
			{ id = 'g000ig9018', amount = 1, weight = 1 }, -- Сфера Прорицательницы 400
			{ id = 'g001ig0134', amount = 1, weight = 1 }, -- Сфера Урона II 400
			{ id = 'g001ig0191', amount = 1, weight = 1 }, -- Сфера Вампира 400
			{ id = 'g001ig0474', amount = 1, weight = 1 }, -- Сфера Скалы 400
			{ id = 'g001ig0461', amount = 1, weight = 1 }, -- Сфера Массового ослабления I 400
			{ id = 'g001ig0479', amount = 1, weight = 1 }, -- Сфера Разрушения доспеха II 400
			{ id = 'g001ig0454', amount = 1, weight = 1 }, -- Сфера Помощи 400
			{ id = 'g001ig0295', amount = 1, weight = 1 }, -- Сфера Замедления 400
		}
	},
	staff_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0406', amount = 1, weight = 1 }, -- Посох провидицы 400
			{ id = 'g001ig0392', amount = 1, weight = 1 }, -- Посох знаний Фрегги 400
			{ id = 'g001ig0380', amount = 1, weight = 1 }, -- Посох врат Бездны 400
			{ id = 'g000ig6021', amount = 1, weight = 1 }, -- Посох Зов Леса 400
		}
	},
	staff_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0401', amount = 1, weight = 1 }, -- Посох проклятой метки 400
			{ id = 'g001ig0404', amount = 1, weight = 1 }, -- Посох Ниграэля 400
			{ id = 'g001ig0403', amount = 1, weight = 1 }, -- Посох неизбежной кары 400
			{ id = 'g000ig6019', amount = 1, weight = 1 }, -- Посох Листвы 400
		}
	},
	scrolls_heal_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5007', amount = 1, weight = 1 }, -- Свиток "Исцеление" 200
			{ id = 'g000ig5029', amount = 1, weight = 1 }, -- Свиток "Ритуал исцеления" 400
		}
	},
	scrolls_heal_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5040', amount = 1, weight = 1 }, -- Свиток "Песнь Вотана" 550
		}
	},
	scrolls_summon = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5031', amount = 1, weight = 1 }, -- Свиток "Призыв II: Валькирия" 550
			{ id = 'g001ig0076', amount = 1, weight = 1 }, -- Свиток "Призыв III: Каменная сущность" 550
			{ id = 'g000ig5071', amount = 1, weight = 1 }, -- Свиток "Призыв III: Кошмар" 550
			{ id = 'g001ig0075', amount = 1, weight = 1 }, -- Свиток "Призыв III: Ледяная сущность" 550
			{ id = 'g001ig0074', amount = 1, weight = 1 }, -- Свиток "Призыв III: Сущность бури" 550
			{ id = 'g001ig0077', amount = 1, weight = 1 }, -- Свиток "Призыв III: Сущность пламени" 550
			{ id = 'g000ig5108', amount = 1, weight = 1 }, -- Свиток "Призыв III: Энт Большой" 550
		}
	},
	scrolls_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5052', amount = 1, weight = 1 }, -- Свиток "Divis nocte" 550
			{ id = 'g001ig0577', amount = 1, weight = 1 }, -- Свиток "Dominatum ignis" 550
			{ id = 'g000ig5054', amount = 1, weight = 1 }, -- Свиток "Menta potens" 550
			{ id = 'g000ig5089', amount = 1, weight = 1 }, -- Свиток "Preces" 550
			{ id = 'g000ig5051', amount = 0, weight = 1 }, -- Свиток "Sanctuera" 550
			{ id = 'g001ig0570', amount = 1, weight = 1 }, -- Свиток "Terra oblivionem" 550
			{ id = 'g000ig5109', amount = 1, weight = 1 }, -- Свиток "Блуждающий Огонек" 550
			{ id = 'g000ig5033', amount = 1, weight = 1 }, -- Свиток "Буря" 550
			{ id = 'g000ig5026', amount = 1, weight = 1 }, -- Свиток "Гимн кланов" 550
			{ id = 'g000ig5014', amount = 1, weight = 1 }, -- Свиток "Гнев Богов" 550
			{ id = 'g000ig5072', amount = 1, weight = 1 }, -- Свиток "Драконья гниль" 550
			{ id = 'g000ig5011', amount = 1, weight = 1 }, -- Свиток "Защита от магии Разума" 550
			{ id = 'g000ig5018', amount = 1, weight = 1 }, -- Свиток "Защита от магии Смерти" 550
			{ id = 'g000ig5079', amount = 1, weight = 1 }, -- Свиток "Защита от Оружия" 550
			{ id = 'g000ig5110', amount = 1, weight = 1 }, -- Свиток "Излечение" 550
			{ id = 'g000ig5085', amount = 1, weight = 1 }, -- Свиток "Искусный торговец" 550
			{ id = 'g001ig0580', amount = 1, weight = 1 }, -- Свиток "Небесный молот" 550
			{ id = 'g001ig0572', amount = 1, weight = 1 }, -- Свиток "Неотвратимая месть" 550
			{ id = 'g000ig5111', amount = 1, weight = 1 }, -- Свиток "Отвлечение" 550
			{ id = 'g000ig5040', amount = 1, weight = 1 }, -- Свиток "Песнь Вотана" 550
			{ id = 'g001ig0165', amount = 1, weight = 1 }, -- Свиток "Плесень" 550
			{ id = 'g001ig0576', amount = 1, weight = 1 }, -- Свиток "Прах к праху" 550
			{ id = 'g000ig5096', amount = 0, weight = 1 }, -- Свиток "Прикосновение вампира" 550
			{ id = 'g000ig5073', amount = 1, weight = 1 }, -- Свиток "Прикосновение Мортис" 550
			{ id = 'g001ig0578', amount = 1, weight = 1 }, -- Свиток "Пробирающий холод" 550
			{ id = 'g000ig5012', amount = 1, weight = 1 }, -- Свиток "Святая броня" 550
			{ id = 'g000ig5013', amount = 1, weight = 1 }, -- Свиток "Святая сила" 550
			{ id = 'g000ig5074', amount = 1, weight = 1 }, -- Свиток "Туман Смерти" 550
			{ id = 'g001ig0579', amount = 1, weight = 1 }, -- Свиток "Хворь" 550
		}
	},
	scrolls_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5050', amount = 1, weight = 1 }, -- Свиток "Chronos" 400
			{ id = 'g001ig0253', amount = 1, weight = 1 }, -- Свиток "Проклятие Имира" 400
			{ id = 'g001ig0255', amount = 1, weight = 1 }, -- Свиток "Спешащее время" 400
			{ id = 'g001ig0256', amount = 1, weight = 1 }, -- Свиток "Могущество" 400
		}
	},
	scrolls_3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5103', amount = 1, weight = 1 }, -- Свиток "Призыв II: Энт" 400
			{ id = 'g000ig5030', amount = 1, weight = 1 }, -- Свиток "Взгляд Сивиллы" 400
			{ id = 'g000ig5104', amount = 1, weight = 1 }, -- Свиток "Опаление" 400
			{ id = 'g001ig0085', amount = 1, weight = 1 }, -- Свиток "Потоп" 450
		}
	},
	scrolls_4 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5084', amount = 1, weight = 1 }, -- Свиток "Дар" 200
		}
	},
	scrolls_ward = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5005', amount = 1, weight = 1 }, -- Свиток "Защита от магии Воды" 400
			{ id = 'g000ig5001', amount = 1, weight = 1 }, -- Свиток "Защита от магии Воздуха" 400
			{ id = 'g000ig5010', amount = 1, weight = 1 }, -- Свиток "Защита от магии Земли" 400
			{ id = 'g000ig5016', amount = 1, weight = 1 }, -- Свиток "Защита от магии Огня" 400
			{ id = 'g000ig5011', amount = 1, weight = 1 }, -- Свиток "Защита от магии Разума" 550
			{ id = 'g000ig5018', amount = 1, weight = 1 }, -- Свиток "Защита от магии Смерти" 550
			{ id = 'g000ig5079', amount = 1, weight = 1 }, -- Свиток "Защита от Оружия" 550
		}
	},
}
--- Лавка т3
Pools.goods.t3 = {
	heal = {
		priority = PoolPriority.ALL,
		items = {
			{ id = Items.heal.hres, amount = 5, weight = 1 },
			{ id = Items.heal.h100, amount = 6, weight = 1 },
			{ id = Items.heal.h75, amount = 7, weight = 1 },
			{ id = Items.heal.h50, amount = 8, weight = 1 },
			{ id = Items.heal.h200, amount = 1, weight = 1 },
		}
	},
	buff_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig0012', amount = 2, weight = 1 }, -- Эликсир скорости 425
			{ id = 'g000ig0015', amount = 2, weight = 1 }, -- Эликсир силы 425
			{ id = 'g000ig0003', amount = 1, weight = 1 }, -- Дубовый эликсир 525
			{ id = 'g000ig0009', amount = 1, weight = 1 }, -- Эликсир точности 350
		}
	},
	buff_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g002ig0007', amount = 2, weight = 1 }, -- Зелье магической устойчивости 250
			{ id = 'g002ig0005', amount = 2, weight = 1 }, -- Зелье наблюдательности 350
			{ id = 'g002ig0006', amount = 1, weight = 1 }, -- Зелье бдительности 550
		}
	},
	permo_ward_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0328', amount = 1, weight = 1 }, -- Эликсир ледяной плоти 400 (мороз)
			{ id = 'g001ig0330', amount = 1, weight = 1 }, -- Эликсир Неопалимых 400 (ожог)
			{ id = 'g001ig0332', amount = 1, weight = 1 }, -- Зелье ихора Танатоса 400 (яд)
			{ id = 'g001ig0342', amount = 1, weight = 1 }, -- Эликсир норн 400 (страх)
			{ id = 'g001ig0344', amount = 1, weight = 1 }, -- Эликсир предназначения 400 (замедление)
			{ id = 'g001ig0346', amount = 1, weight = 1 }, -- Эликсир неудержимости 400 (ослабление)
		}
	},
	permo_ward_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0320', amount = 1, weight = 1 }, -- Зелье глубинного чудища 600 (вода)
			{ id = 'g001ig0321', amount = 1, weight = 1 }, -- Зелье укротителя небосвода 600 (воздух)
			{ id = 'g001ig0322', amount = 1, weight = 1 }, -- Зелье текучего камня 600 (земля)
			{ id = 'g001ig0323', amount = 1, weight = 1 }, -- Зелье родства с пламенем 600 (огонь)
			{ id = 'g001ig0325', amount = 1, weight = 1 }, -- Зелье здравомыслия 900 (разум)
			{ id = 'g001ig0326', amount = 1, weight = 1 }, -- Зелье немертвых 900 (смерть)
			{ id = 'g001ig0334', amount = 1, weight = 1 }, -- Эликсир безраздельности 800 (имитация)
			{ id = 'g001ig0336', amount = 1, weight = 1 }, -- Эликсир павших оков 800 (окаменение)
			{ id = 'g001ig0338', amount = 1, weight = 1 }, -- Эликсир непоколебимости 800 (паралич)
			{ id = 'g001ig0340', amount = 1, weight = 1 }, -- Эликсир непорочности 800 (полиморф)
			{ id = 'g001ig0352', amount = 1, weight = 1 }, -- Эликсир гонителя нечисти 800 (вамризм+тауматургия)
			{ id = 'g001ig0354', amount = 1, weight = 1 }, -- Жидкий металл Уру 450 (РБ)
		}
	},
	permo_stat = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0308', amount = 1, weight = 1 }, -- Зелье заступника 1200 (броня)
			{ id = 'g001ig0310', amount = 1, weight = 1 }, -- Эликсир опережения 1200 (инициатива)
			{ id = 'g001ig0314', amount = 1, weight = 1 }, -- Эликсир наследия 1200 (урон)
			{ id = 'g001ig0316', amount = 1, weight = 1 }, -- Сок Великого древа 1200 (ОЗ)
			{ id = 'g001ig0522', amount = 1, weight = 1 }, -- Зелье посла 2000 (благородство)
		}
	},
	artifact_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig9137', amount = 1, weight = 1 }, -- Сердце Имира (Артефакт) 800
			{ id = 'g001ig0591', amount = 1, weight = 1 }, -- Щит отражения (Артефакт) 900
			{ id = 'g001ig0197', amount = 1, weight = 1 }, -- Проклятый пепел (Артефакт) 950
			{ id = 'g001ig0071', amount = 1, weight = 1 }, -- Эльфийская брошь (Артефакт) 1000
			{ id = 'g001ig0612', amount = 1, weight = 1 }, -- Кольцо небесной воли (Артефакт) 1000
			{ id = 'g001ig0124', amount = 1, weight = 1 }, -- Клинок Возвышенного (Артефакт) 1000
			{ id = 'g000ig3019', amount = 1, weight = 1 }, -- Клинок Танатоса (Артефакт) 1150
			{ id = 'g001ig0415', amount = 1, weight = 1 }, -- Руна кары Тьяцци (Артефакт) 1150
			{ id = 'g001ig0060', amount = 1, weight = 1 }, -- Тысяча чешуек (Артефакт) 1200
			{ id = 'g000ig2004', amount = 1, weight = 1 }, -- Рог всеведенья (Артефакт) 1200
			{ id = 'g001ig0590', amount = 1, weight = 1 }, -- Щит Мизраэля (Артефакт) 1200
			{ id = 'g000ig3004', amount = 1, weight = 1 }, -- Рунический клинок (Артефакт) 1200
			{ id = 'g000ig9035', amount = 1, weight = 1 }, -- Слеза Мортис (Артефакт) 1200
			{ id = 'g001ig0413', amount = 1, weight = 1 }, -- Корни триббога (Артефакт) 1200
			{ id = 'g001ig0158', amount = 1, weight = 1 }, -- Ужасающий топор (Артефакт) 1200
		}
	},
	artifact_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0585', amount = 1, weight = 2 }, -- Кольцо создателя (Артефакт) 1400
			{ id = 'g001ig0411', amount = 1, weight = 2 }, -- Грань реальности (Артефакт) 1400
			{ id = 'g001ig0046', amount = 1, weight = 2 }, -- Кровь Владыки (Артефакт) 1400
			{ id = 'g001ig0155', amount = 1, weight = 1 }, -- Благословенный браслет (Артефакт) 1400
			{ id = 'g001ig0488', amount = 1, weight = 2 }, -- Кольцо Несгибаемого стража (Артефакт) 1500
			{ id = 'g001ig0410', amount = 1, weight = 2 }, -- Дьявольская булава (Артефакт) 1500
			{ id = 'g002ig0017', amount = 1, weight = 1 }, -- Копье Ангела (Артефакт) 1750
			{ id = 'g001ig0179', amount = 1, weight = 1 }, -- Боевая коса (Артефакт) 1750
			{ id = 'g001ig0102', amount = 1, weight = 2 }, -- Коготь Пожирателя (Артефакт) 1800
			{ id = 'g000ig2005', amount = 1, weight = 2 }, -- Гравированная диадема (Артефакт) 1800
			{ id = 'g001ig0043', amount = 1, weight = 2 }, -- Мощь дракона (Артефакт) 2600
		}
	},
	relic_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0430', amount = 1, weight = 1 }, -- Роба убийцы (Реликвия) 850
			{ id = 'g001ig0419', amount = 1, weight = 1 }, -- Шлем воителя (Реликвия) 1000
			{ id = 'g000ig3005', amount = 1, weight = 1 }, -- Корона Мьольнира (Реликвия) 1200
			{ id = 'g001ig0116', amount = 1, weight = 1 }, -- Пластинчатый доспех (Реликвия) 1550
			{ id = 'g001ig0038', amount = 1, weight = 1 }, -- Тяжелые латы (Реликвия) 1550
			{ id = 'g000ig7010', amount = 1, weight = 1 }, -- Корона Империи (Реликвия) 1800
		}
	},
	boots = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig1010', amount = 1, weight = 1 }, -- Эльфийские сапоги 700
			{ id = 'g000ig8003', amount = 1, weight = 1 }, -- Сапоги скорости 700
			{ id = 'g001ig0606', amount = 1, weight = 1 }, -- Сапоги родных земель 1000
		}
	},
	banner_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0363', amount = 1, weight = 1 }, -- Знамя отваги 750
			{ id = 'g000ig1002', amount = 1, weight = 1 }, -- Знамя неуязвимости 850
			{ id = 'g001ig0364', amount = 1, weight = 1 }, -- Знамя ветра перемен 900
			{ id = 'g001ig0374', amount = 1, weight = 1 }, -- Знамя стального листопада 900
			{ id = 'g001ig0358', amount = 1, weight = 1 }, -- Знамя ража 950
			{ id = 'g001ig0362', amount = 1, weight = 1 }, -- Знамя болот 950
		}
	},
	banner_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0375', amount = 1, weight = 1 }, -- Знамя наследия 1000
			{ id = 'g001ig0052', amount = 1, weight = 1 }, -- Знамя стойких 1300
			{ id = 'g000ig1017', amount = 1, weight = 1 }, -- Знамя Здоровья 1500
			{ id = 'g001ig0290', amount = 1, weight = 1 }, -- Стяг непреклонности 1600
			{ id = 'g001ig0291', amount = 1, weight = 1 }, -- Штандарт равновесия 1600
		}
	},
	talisman_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig9130', amount = 1, weight = 1 }, -- Талисман бури 1000
			{ id = 'g000ig9123', amount = 1, weight = 1 }, -- Талисман пожара 1000
			{ id = 'g001ig0202', amount = 1, weight = 1 }, -- Талисман души чародея 1000
			{ id = 'g000ig9103', amount = 1, weight = 1 }, -- Талисман души героя 1200
			{ id = 'g000ig9136', amount = 1, weight = 1 }, -- Талисман горы 1600
			{ id = 'g001ig0185', amount = 1, weight = 1 }, -- Талисман землетрясения 1800
			{ id = 'g000ig9119', amount = 1, weight = 1 }, -- Талисман Всевышнего 1000
		}
	},
	sphere_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0478', amount = 1, weight = 1 }, -- Сфера Переохлаждения 500
			{ id = 'g001ig0467', amount = 1, weight = 1 }, -- Сфера Бури 500
			{ id = 'g000ig9024', amount = 1, weight = 1 }, -- Сфера Жажды 500
			{ id = 'g001ig0469', amount = 1, weight = 1 }, -- Сфера Пожара 500
			{ id = 'g001ig0304', amount = 1, weight = 1 }, -- Сфера Боли 500
			{ id = 'g001ig0468', amount = 1, weight = 1 }, -- Сфера Оползня 500
			{ id = 'g001ig0443', amount = 1, weight = 1 }, -- Сфера Брони II 600
		}
	},
	sphere_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0462', amount = 1, weight = 1 }, -- Сфера направленного ослабления II 700
			{ id = 'g001ig0455', amount = 1, weight = 1 }, -- Сфера Спасения 700
			{ id = 'g001ig0489', amount = 1, weight = 1 }, -- Сфера Угнетения 700
			{ id = 'g001ig0131', amount = 1, weight = 1 }, -- Сфера Урона III 700
			{ id = 'g000ig9028', amount = 1, weight = 1 }, -- Сфера Грозы 700
			{ id = 'g000ig9021', amount = 1, weight = 1 }, -- Сфера Вампиризма III 700
			{ id = 'g000ig9016', amount = 1, weight = 1 }, -- Сфера Великого исцеления 700
			{ id = 'g001ig0203', amount = 1, weight = 1 }, -- Сфера Массового ослабления II 700
			{ id = 'g001ig0466', amount = 1, weight = 1 }, -- Сфера Морской пучины 700
			{ id = 'g001ig0183', amount = 1, weight = 1 }, -- Сфера Обширной коррозии II 700
		}
	},
	sphere_3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0457', amount = 1, weight = 1 }, -- Сфера Испепеления 800
			{ id = 'g001ig0480', amount = 1, weight = 1 }, -- Сфера Горы 800
			{ id = 'g001ig0059', amount = 1, weight = 1 }, -- Сфера защиты от Оружия 800
			{ id = 'g001ig0136', amount = 1, weight = 1 }, -- Сфера Брони III 800
			{ id = 'g001ig0303', amount = 1, weight = 1 }, -- Сфера Древнего 800
			{ id = 'g000ig9020', amount = 0, weight = 1 }, -- Сфера Энергии 1000
			{ id = 'g000ig9014', amount = 1, weight = 1 }, -- Сфера Массового замедления 1000
		}
	},
	staff_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig6020', amount = 1, weight = 1 }, -- Посох Возни 550
			{ id = 'g000ig6014', amount = 1, weight = 1 }, -- Посох защиты 550
			{ id = 'g001ig0391', amount = 1, weight = 1 }, -- Посох оракула 550
			{ id = 'g000ig6011', amount = 1, weight = 1 }, -- Посох повелителя драконов 550
			{ id = 'g001ig0398', amount = 1, weight = 1 }, -- Посох скальда 550
			{ id = 'g001ig0400', amount = 1, weight = 1 }, -- Посох созыва шабаша 550
		}
	},
	staff_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig6016', amount = 1, weight = 1 }, -- Посох бури 700
			{ id = 'g000ig6018', amount = 1, weight = 1 }, -- Посох сумерек 700
			{ id = 'g001ig0097', amount = 1, weight = 1 }, -- Посох озер 700
			{ id = 'g000ig6015', amount = 1, weight = 1 }, -- Посох Всевышнего 700
			{ id = 'g000ig6017', amount = 0, weight = 1 }, -- Посох дневного света 700
			{ id = 'g000ig6009', amount = 1, weight = 1 }, -- Посох земли 700
		}
	},
}

------------------------------------------------------------------------------------------------------------------------
--- Предметы -> Пермобанки навыков
Pools.items.perks = {}
------------------------------------------------------------------------------------------------------------------------
Pools.items.perks.pool_1 = {
	priority = PoolPriority.AS_POSSIBLE,
	items = {
		{ id = 'g001ig0526', amount = 1, weight = 1 }, -- Зелье оруженосца 600 (знаменосец)
		{ id = 'g001ig0527', amount = 1, weight = 1 }, -- Зелье постижения 600 (тайное знание)
	}
}
Pools.items.perks.pool_2a = {
	priority = PoolPriority.ALL,
	items = {
		{ id = 'g001ig0529', amount = 1, weight = 1 }, -- Каталог магических сфер 600 (сферы)
	}
}
Pools.items.perks.pool_2b = {
	priority = PoolPriority.AS_POSSIBLE,
	items = {
		{ id = 'g001ig0531', amount = 1, weight = 1 }, -- Зелье слова 500 (свитки)
	}
}
Pools.items.perks.pool_3 = {
	priority = PoolPriority.AS_POSSIBLE,
	items = {
		{ id = 'g001ig0525', amount = 1, weight = 1 }, -- Эликсир учености 600 (артефакты)
		{ id = 'g001ig0528', amount = 1, weight = 1 }, -- Честный труд 600 (походное снаряжение)
	}
}

------------------------------------------------------------------------------------------------------------------------
--- Предметы -> Лут
Pools.loot = {}
------------------------------------------------------------------------------------------------------------------------
--- Лут т0
Pools.loot.t0 = {
	res = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.hres, amount = 2, weight = 1 },
		}
	},
	heal = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.h25, amount = 1, weight = 1 },
			{ id = Items.heal.h50, amount = 1, weight = 1 },
			{ id = Items.heal.h75, amount = 2, weight = 1 },
			{ id = Items.heal.h100, amount = 1, weight = 1 },
		}
	},
	buff_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig0002', amount = 1, weight = 1 }, -- Эликсир защиты 150
			{ id = 'g000ig0014', amount = 1, weight = 1 }, -- Эликсир энергии 150
			{ id = 'g000ig0008', amount = 1, weight = 1 }, -- Эликсир меткости 150
			{ id = 'g000ig0011', amount = 1, weight = 1 }, -- Эликсир ловкости 150
		}
	},
	ward_el = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig0021', amount = 1, weight = 1 }, -- Эликсир защиты от магии Воздуха 250
			{ id = 'g000ig0022', amount = 1, weight = 1 }, -- Эликсир защиты от магии Воды 250
			{ id = 'g000ig0023', amount = 1, weight = 1 }, -- Эликсир защиты от магии Земли 250
			{ id = 'g000ig0024', amount = 1, weight = 1 }, -- Эликсир защиты от магии Огня 250
		}
	},
	ward_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0560', amount = 1, weight = 1 }, -- Зелье провокатора 200
			{ id = 'g001ig0547', amount = 1, weight = 1 }, -- Зелье пронзающего взгляда 300
			{ id = 'g001ig0329', amount = 1, weight = 1 }, -- Эликсир защиты от болезней 375
			{ id = 'g001ig0351', amount = 1, weight = 1 }, -- Эликсир защиты от поглощения 375
			{ id = 'g001ig0343', amount = 1, weight = 1 }, -- Эликсир защиты от проклятий 375
		}
	},
	orb = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0176', amount = 1, weight = 1 }, -- Сфера Вампиризма II 400
			{ id = 'g001ig0134', amount = 1, weight = 1 }, -- Сфера Урона II 400
			{ id = 'g001ig0443', amount = 1, weight = 1 }, -- Сфера Брони II 400
		}
	},
	talisman = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig9101', amount = 2, weight = 1, races = {Race.Human} }, -- Талисман Сквайра 200
			{ id = 'g001ig0265', amount = 2, weight = 1, races = {Race.Dwarf} }, -- Талисман кузнеца 200
			{ id = 'g001ig0264', amount = 2, weight = 1, races = {Race.Undead} }, -- Талисман мертвеца 200
			{ id = 'g001ig0267', amount = 2, weight = 1, races = {Race.Heretic} }, -- Талисман еретика 200
			{ id = 'g001ig0266', amount = 2, weight = 1, races = {Race.Elf} }, -- Талисман лесного воина - 200
			{ id = 'g000ig9105', amount = 2, weight = 1 }, -- Талисман костра 200
			{ id = 'g000ig9131', amount = 2, weight = 1 }, -- Талисман ливня 200
		}
	},
	scroll = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5084', amount = 1, weight = 1 }, -- Свиток "Дар" 200
		}
	},
}
--- Лут т1
Pools.loot.t1 = {
	heal = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.hres, amount = 3, weight = 1 },
			{ id = Items.heal.h75, amount = 4, weight = 1 },
			{ id = Items.heal.h100, amount = 4, weight = 1 },
		}
	},
	gold = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.gold.g125, amount = 1, weight = 1 },
		}
	},
	ward_el = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig0021', amount = 1, weight = 1 }, -- Эликсир защиты от магии Воздуха 250
			{ id = 'g000ig0022', amount = 1, weight = 1 }, -- Эликсир защиты от магии Воды 250
			{ id = 'g000ig0023', amount = 1, weight = 1 }, -- Эликсир защиты от магии Земли 250
			{ id = 'g000ig0024', amount = 1, weight = 1 }, -- Эликсир защиты от магии Огня 250
		}
	},
	ward_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0125', amount = 1, weight = 1 }, -- Эликсир защиты от магии Разума 250
			{ id = 'g001ig0036', amount = 1, weight = 1 }, -- Эликсир защиты от магии Смерти 250
		}
	},
	permo_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0533', amount = 1, weight = 1 }, -- Зелье ясного взора - 400
			{ id = 'g001ig0026', amount = 1, weight = 1 }, -- Аура регенерации - 400
		}
	},
	orb = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0133', amount = 1, weight = 1 }, -- Сфера Брони I - 200
			{ id = 'g001ig0446', amount = 1, weight = 1 }, -- Сфера Вампиризма I - 200
			{ id = 'g000ig9017', amount = 1, weight = 1 }, -- Сфера Восстановления - 200
			{ id = 'g001ig0471', amount = 1, weight = 1 }, -- Сфера Охотника - 200
			{ id = 'g001ig0464', amount = 1, weight = 1 }, -- Сфера Разрушения доспеха I - 200
			{ id = 'g001ig0450', amount = 1, weight = 1 }, -- Сфера Урона I - 200
		}
	},
	talisman = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0184', amount = 1, weight = 1 }, -- Талисман восстановления - 400
			{ id = 'g000ig9109', amount = 1, weight = 1 }, -- Талисман души создата - 450
			{ id = 'g000ig9120', amount = 1, weight = 1 }, -- Талисман щита стихий - 500
		}
	},
	scrolls = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5084', amount = 1, weight = 1 }, -- Свиток "Дар" - 200
		}
	},
}
--- Лут т2
Pools.loot.t2 = {
	heal_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.hres, amount = 6, weight = 1 },
		}
	},
	heal_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.h25, amount = 1, weight = 1, group_amount = 4 },
			{ id = Items.heal.h50, amount = 4, weight = 1, group_amount = 2 },
			{ id = Items.heal.h75, amount = 1, weight = 1 },
			{ id = Items.heal.h100, amount = 8, weight = 1 },
		}
	},
	gold = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.gold.g75, amount = 1, weight = 1 },
			{ id = Items.gold.g100, amount = 1, weight = 1 },
			{ id = Items.gold.g125, amount = 1, weight = 1 },
			{ id = Items.gold.g150, amount = 1, weight = 1 },
		}
	},
	buff_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g002ig0007', amount = 1, weight = 2 }, -- Зелье магической устойчивости 250
			{ id = 'g002ig0005', amount = 1, weight = 2 }, -- Зелье наблюдательности 350
			{ id = 'g002ig0006', amount = 1, weight = 2 }, -- Зелье бдительности 550
			{ id = 'g002ig0008', amount = 1, weight = 4 }, -- Эликсир скрытого потенциала 350
			{ id = 'g001ig0560', amount = 1, weight = 1 }, -- Зелье провокатора 200
			{ id = 'g001ig0547', amount = 1, weight = 1 }, -- Зелье пронзающего взгляда 300
			{ id = 'g001ig0329', amount = 1, weight = 1 }, -- Эликсир защиты от болезней 375
			{ id = 'g001ig0351', amount = 1, weight = 1 }, -- Эликсир защиты от поглощения 375
			{ id = 'g001ig0343', amount = 1, weight = 1 }, -- Эликсир защиты от проклятий 375
		}
	},
	buff_3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g002ig0007', amount = 2, weight = 1 }, -- Зелье магической устойчивости 250
			{ id = 'g002ig0005', amount = 1, weight = 1 }, -- Зелье наблюдательности 350
		}
	},
	ward_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0125', amount = 2, weight = 1 }, -- Эликсир защиты от магии Разума 250
			{ id = 'g001ig0036', amount = 2, weight = 1 }, -- Эликсир защиты от магии Смерти 250
		}
	},
	ward_3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0128', amount = 1, weight = 4 }, -- Эликсир защиты от Оружия 400
			{ id = 'g001ig0329', amount = 1, weight = 1 }, -- Эликсир защиты от болезней 375
			{ id = 'g001ig0341', amount = 1, weight = 1 }, -- Эликсир защиты сознания 500
			{ id = 'g001ig0343', amount = 1, weight = 1 }, -- Эликсир защиты от проклятий 375
			{ id = 'g001ig0351', amount = 1, weight = 1 }, -- Эликсир защиты от поглощения 375
		}
	},
	perk = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0524', amount = 1, weight = 1 }, -- Зелье завоевателя 500
			{ id = 'g001ig0531', amount = 1, weight = 1 }, -- Зелье слова 500
		}
	},
	permo_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0516', amount = 1, weight = 1 }, -- Зелье омоложения разума 600
		}
	},
	permo_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0328', amount = 1, weight = 1 }, -- Эликсир ледяной плоти 400 (мороз)
			{ id = 'g001ig0330', amount = 1, weight = 1 }, -- Эликсир Неопалимых 400 (ожог)
			{ id = 'g001ig0332', amount = 1, weight = 1 }, -- Зелье ихора Танатоса 400 (яд)
			{ id = 'g001ig0342', amount = 1, weight = 1 }, -- Эликсир норн 400 (страх)
			{ id = 'g001ig0344', amount = 1, weight = 1 }, -- Эликсир предназначения 400 (замедление)
			{ id = 'g001ig0346', amount = 1, weight = 1 }, -- Эликсир неудержимости 400 (ослабление)
		}
	},
	permo_3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0022', amount = 1, weight = 1 }, -- Аура меткости 600 (10% точности)
			{ id = 'g001ig0029', amount = 1, weight = 1 }, -- Аура силы 600 (5% урона)
			{ id = 'g000ig0010', amount = 1, weight = 1 }, -- Эликсир внимательности 500 (10% точности)
			{ id = 'g001ig0083', amount = 1, weight = 1 }, -- Зелье рвения 500 (5% инициативы + 5% точности)
			{ id = 'g001ig0561', amount = 1, weight = 1 }, -- Эликсир самопожертвования 600 (25% телохранитель)
			{ id = 'g001ig0320', amount = 1, weight = 1 }, -- Зелье глубинного чудища 600 (защита от Воды)
			{ id = 'g001ig0321', amount = 1, weight = 1 }, -- Зелье укротителя небосвода 600 (защита от Воздуха)
			{ id = 'g001ig0322', amount = 1, weight = 1 }, -- Зелье текучего камня 600 (защита от Земли)
			{ id = 'g001ig0323', amount = 1, weight = 1 }, -- Зелье родства с пламенем 600 (защита от Огня)
		}
	},
	orb = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0191', amount = 1, weight = 1 }, -- Сфера Вампира 400
			{ id = 'g001ig0176', amount = 1, weight = 1 }, -- Сфера Вампиризма II 400
			{ id = 'g001ig0295', amount = 1, weight = 1 }, -- Сфера Замедления - 400
			{ id = 'g001ig0056', amount = 1, weight = 1 }, -- Сфера защиты от магии Воды 400
			{ id = 'g001ig0054', amount = 1, weight = 1 }, -- Сфера защиты от магии Воздуха 400
			{ id = 'g001ig0055', amount = 1, weight = 1 }, -- Сфера защиты от магии Земли 400
			{ id = 'g001ig0053', amount = 1, weight = 1 }, -- Сфера защиты от магии Огня 400
			{ id = 'g001ig0058', amount = 1, weight = 1 }, -- Сфера защиты от магии Разума 400
			{ id = 'g001ig0057', amount = 1, weight = 1 }, -- Сфера защиты от магии Смерти 400
			{ id = 'g001ig0461', amount = 1, weight = 1 }, -- Сфера Массового ослабления I 400
			{ id = 'g001ig0300', amount = 1, weight = 1 }, -- Сфера Молнии 400
			{ id = 'g001ig0496', amount = 1, weight = 1 }, -- Сфера Мучений 400
			{ id = 'g000ig9042', amount = 1, weight = 1 }, -- Сфера направленного ослабления I 400
			{ id = 'g001ig0475', amount = 1, weight = 1 }, -- Сфера Обширной коррозии I 400
			{ id = 'g001ig0157', amount = 1, weight = 1 }, -- Сфера очищения 400
			{ id = 'g001ig0187', amount = 1, weight = 1 }, -- Сфера Пламени 400
			{ id = 'g001ig0454', amount = 1, weight = 1 }, -- Сфера Помощи 400
			{ id = 'g001ig0456', amount = 1, weight = 1 }, -- Сфера Прилива 400
			{ id = 'g000ig9018', amount = 1, weight = 1 }, -- Сфера Прорицательницы 400
			{ id = 'g001ig0479', amount = 1, weight = 1 }, -- Сфера Разрушения доспеха II 400
			{ id = 'g001ig0453', amount = 1, weight = 1 }, -- Сфера Святой земли 400
			{ id = 'g001ig0474', amount = 1, weight = 1 }, -- Сфера Скалы 400
			{ id = 'g001ig0134', amount = 1, weight = 1 }, -- Сфера Урона II 400
		}
	},
	talisman = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0259', amount = 1, weight = 1 }, -- Талисман души хитреца 600
			{ id = 'g000ig9128', amount = 1, weight = 1 }, -- Талисман молнии 800
			{ id = 'g001ig0063', amount = 1, weight = 1 }, -- Талисман прилива 800
			{ id = 'g000ig9116', amount = 1, weight = 1 }, -- Талисман святой земли 800
		}
	},
	scrolls_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5014', amount = 1, weight = 1 }, -- Свиток "Гнев Богов" 550 (40 урона)
			{ id = 'g000ig5033', amount = 1, weight = 1 }, -- Свиток "Буря" 550 (40 урона)
			{ id = 'g000ig5054', amount = 1, weight = 1 }, -- Свиток "Menta potens" 550 (40 урона)
			{ id = 'g000ig5072', amount = 1, weight = 1 }, -- Свиток "Драконья гниль" 550 (40 урона)
			{ id = 'g000ig5109', amount = 1, weight = 1 }, -- Свиток "Блуждающий Огонек" 550 (40 урона)

			{ id = 'g000ig5040', amount = 1, weight = 1 }, -- Свиток "Песнь Вотана" 550 (лечение 100)
			{ id = 'g000ig5110', amount = 1, weight = 1 }, -- Свиток "Излечение" 550 (лечение 60 3x3)

			{ id = 'g001ig0576', amount = 1, weight = 1 }, -- Свиток "Прах к праху" 550 (-Смерть/Вампиризм/Тауматургия)
			{ id = 'g001ig0577', amount = 1, weight = 1 }, -- Свиток "Dominatum ignis" 550 (-Огонь/Ожог)
			{ id = 'g001ig0578', amount = 1, weight = 1 }, -- Свиток "Пробирающий холод" 550 (-Вода/Обморожение)
			{ id = 'g001ig0579', amount = 1, weight = 1 }, -- Свиток "Хворь" 550 (-Земля/Яд)
			{ id = 'g001ig0580', amount = 1, weight = 1 }, -- Свиток "Небесный молот 550" (-Воздух/РБ)
		}
	},
	scrolls_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5099', amount = 1, weight = 1 }, -- Свиток "Опутывание" 400
			{ id = 'g002ig0023', amount = 1, weight = 1 }, -- Свиток "Забвение" 400
		}
	},
}
--- Лут т3
Pools.loot.t3 = {
	heal_1 = { -- res / 100
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.hres, amount = 3, weight = 1 },
			{ id = Items.heal.h100, amount = 3, weight = 1 },
		}
	},
	heal_2 = { -- 100
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.h25, amount = 2, weight = 1, group_amount = 4 },
			{ id = Items.heal.h50, amount = 8, weight = 1, group_amount = 2 },
		}
	},
	heal_3 = { -- 150
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.h50, amount = 3, weight = 1, group_amount = 3 },
			{ id = Items.heal.h75, amount = 3, weight = 1, group_amount = 2 },
		}
	},
	heal_4 = { -- 200
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.h50, amount = 1, weight = 1, group_amount = 4 },
			{ id = Items.heal.h100, amount = 1, weight = 1, group_amount = 2 },
		}
	},
	heal_5 = { -- res / 150 / 200
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.hres, amount = 1, weight = 1 },
			{ id = Items.heal.h75, amount = 1, weight = 1, group_amount = 2 },
			{ id = Items.heal.h200, amount = 1, weight = 1 },
		}
	},
	heal_6 = { -- res
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.hres, amount = 2, weight = 1 },
		}
	},
	heal_7 = { -- 200 / 300
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.h200, amount = 1, weight = 1 },
			{ id = Items.heal.h300, amount = 1, weight = 1 },
		}
	},
	buff_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g002ig0008', amount = 1, weight = 4 }, -- Эликсир скрытого потенциала 350
			{ id = 'g002ig0006', amount = 1, weight = 4 }, -- Зелье бдительности 550
			{ id = 'g000ig0003', amount = 1, weight = 1 }, -- Дубовый эликсир 525
			{ id = 'g000ig0009', amount = 1, weight = 1 }, -- Эликсир точности 350
			{ id = 'g000ig0015', amount = 1, weight = 1 }, -- Эликсир силы 425
			{ id = 'g000ig0012', amount = 1, weight = 1 }, -- Эликсир скорости 425

		}
	},
	buff_3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0560', amount = 2, weight = 1 }, -- Зелье провокатора 200
			{ id = 'g001ig0547', amount = 2, weight = 1 }, -- Зелье пронзающего взгляда 300
			{ id = 'g002ig0007', amount = 2, weight = 1 }, -- Зелье магической устойчивости 250
			{ id = 'g001ig0128', amount = 2, weight = 1 }, -- Эликсир защиты от Оружия 400

		}
	},
	buff_4 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0562', amount = 2, weight = 1 }, -- Зелье дуэлянта 500
			{ id = 'g001ig0491', amount = 2, weight = 1 }, -- Зелье похищения жизни 500
			{ id = 'g001ig0127', amount = 2, weight = 1 }, -- Эликсир жизненной силы 500
			{ id = 'g001ig0355', amount = 2, weight = 1 }, -- Зелье тритоньей чешуи 600

		}
	},
	permo_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0307', amount = 2, weight = 3 }, -- Зелье стойкости 450 (+5 брони)
			{ id = 'g001ig0309', amount = 2, weight = 3 }, -- Эликсир задиры 400 (+5% инициативы)
			{ id = 'g001ig0311', amount = 2, weight = 3 }, -- Эликсир хладнокровия 400 (+5% точности)
			{ id = 'g001ig0313', amount = 2, weight = 3 }, -- Эликсир совершенствования 400 (+5% урона)
			{ id = 'g001ig0315', amount = 2, weight = 3 }, -- Зелье великана 400 (+5% ОЗ)
			{ id = 'g001ig0336', amount = 1, weight = 1 }, -- Эликсир павших оков 800 (защита от окаменения)
			{ id = 'g001ig0338', amount = 1, weight = 1 }, -- Эликсир непоколебимости 800 (паралич)
      { id = 'g001ig0340', amount = 1, weight = 1 }, -- Эликсир непорочности 800 (полиморф)
		}
	},
	permo_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0308', amount = 2, weight = 1 }, -- Зелье заступника 1200 (+15 брони)
			{ id = 'g001ig0310', amount = 2, weight = 1 }, -- Эликсир опережения 1200 (+15% инициативы)
			{ id = 'g001ig0314', amount = 2, weight = 1 }, -- Эликсир наследия 1200 (+15% урона)
			{ id = 'g001ig0316', amount = 2, weight = 1 }, -- Сок Великого древа 1200 (+15% ОЗ)
		}
	},
	permo_3 = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = 'g001ig0519', amount = 1, weight = 1 }, -- Война престолов 600
		}
	},
	staff_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig6020', amount = 1, weight = 1 }, -- Посох Возни 550
			{ id = 'g001ig0380', amount = 1, weight = 1 }, -- Посох врат Бездны 400
			{ id = 'g001ig0381', amount = 1, weight = 1 }, -- Посох дурных знамений 400
			{ id = 'g000ig6014', amount = 1, weight = 1 }, -- Посох защиты 550
			{ id = 'g001ig0392', amount = 1, weight = 1 }, -- Посох знаний Фрегги 400
			{ id = 'g000ig6021', amount = 1, weight = 1 }, -- Посох Зов Леса 400
			{ id = 'g000ig6019', amount = 1, weight = 1 }, -- Посох Листвы 400
			{ id = 'g001ig0403', amount = 1, weight = 1 }, -- Посох неизбежной кары 400
			{ id = 'g001ig0382', amount = 1, weight = 1 }, -- Посох неусыпного стража 400
			{ id = 'g001ig0404', amount = 1, weight = 1 }, -- Посох Ниграэля 400
			{ id = 'g001ig0391', amount = 1, weight = 1 }, -- Посох оракула 550
			{ id = 'g000ig6011', amount = 1, weight = 1 }, -- Посох повелителя драконов 550
			{ id = 'g001ig0406', amount = 1, weight = 1 }, -- Посох провидицы 400
			{ id = 'g001ig0401', amount = 1, weight = 1 }, -- Посох проклятой метки 400
			{ id = 'g001ig0386', amount = 1, weight = 1 }, -- Посох семи ветров 400
			{ id = 'g001ig0398', amount = 1, weight = 1 }, -- Посох скальда 550
			{ id = 'g001ig0400', amount = 1, weight = 1 }, -- Посох созыва шабаша 550
			{ id = 'g000ig6006', amount = 1, weight = 1 }, -- Посох темноты 400
			{ id = 'g001ig0379', amount = 1, weight = 1 }, -- Треснувший посох врат Бездны 100
			{ id = 'g001ig0098', amount = 1, weight = 1 }, -- Посох морей 1000
		}
	},
	scroll = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig5089', amount = 1, weight = 1 }, -- Свиток "Preces" 550
			{ id = 'g001ig0165', amount = 1, weight = 1 }, -- Свиток "Плесень" 550
			{ id = 'g000ig5073', amount = 1, weight = 1 }, -- Свиток "Прикосновение Мортис" 550
			{ id = 'g000ig5026', amount = 1, weight = 1 }, -- Свиток "Гимн кланов" 550
			{ id = 'g000ig5012', amount = 1, weight = 1 }, -- Свиток "Святая броня" 550
			{ id = 'g000ig5013', amount = 1, weight = 1 }, -- Свиток "Святая сила" 550

			{ id = 'g000ig5031', amount = 1, weight = 1 }, -- Свиток "Призыв II: Валькирия" 550
			{ id = 'g000ig5071', amount = 1, weight = 1 }, -- Свиток "Призыв III: Кошмар" 550
			{ id = 'g000ig5108', amount = 1, weight = 1 }, -- Свиток "Призыв III: Энт Большой" 550
			{ id = 'g001ig0074', amount = 1, weight = 1 }, -- Свиток "Призыв III: Сущность бури" 550
			{ id = 'g001ig0075', amount = 1, weight = 1 }, -- Свиток "Призыв III: Ледяная сущность" 550
			{ id = 'g001ig0076', amount = 1, weight = 1 }, -- Свиток "Призыв III: Каменная сущность" 550
			{ id = 'g001ig0077', amount = 1, weight = 1 }, -- Свиток "Призыв III: Сущность пламени" 550
		}
	},
	orb = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0304', amount = 1, weight = 1 }, -- Сфера Боли 500
			{ id = 'g001ig0467', amount = 1, weight = 1 }, -- Сфера Бури 500
			{ id = 'g000ig9024', amount = 1, weight = 1 }, -- Сфера Жажды 500
			{ id = 'g001ig0468', amount = 1, weight = 1 }, -- Сфера Оползня 500
			{ id = 'g001ig0478', amount = 1, weight = 1 }, -- Сфера Переохлаждения 500
			{ id = 'g001ig0469', amount = 1, weight = 1 }, -- Сфера Пожара 500
			{ id = 'g001ig0443', amount = 1, weight = 1 }, -- Сфера Брони II 600
		}
	},
	talisman = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0202', amount = 4, weight = 2 }, -- Талисман души чародея 1000
			{ id = 'g000ig9130', amount = 4, weight = 2 }, -- Талисман бури 1000
			{ id = 'g000ig9123', amount = 4, weight = 2 }, -- Талисман пожара 1000
			{ id = 'g000ig9124', amount = 4, weight = 1 }, -- Талисман мрака 1000
		}
	},
	misc_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.mana.life.normal, amount = 1, weight = 1 },
			{ id = Items.mana.runic.normal, amount = 1, weight = 1 },
			{ id = Items.mana.death.normal, amount = 1, weight = 1 },
			{ id = Items.mana.infernal.normal, amount = 1, weight = 1 },
			{ id = Items.mana.grove.normal, amount = 1, weight = 1 },
			{ id = Items.gold.g125, amount = 2, weight = 5 },
		}
	},
	misc_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.mana.all.normal, amount = 1, weight = 1 },
			{ id = Items.gold.g150, amount = 1, weight = 1 },
		}
	},
}
--- Лут т4
Pools.loot.t4 = {
	res = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.hres, amount = 1, weight = 1 },
		}
	},
	heal = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.h50, amount = 1, weight = 1, group_amount = 2  },
			{ id = Items.heal.h100, amount = 3, weight = 1 },
		}
	},
	gold = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.gold.g175, amount = 1, weight = 1 },
		}
	},
	buff_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g002ig0006', amount = 1, weight = 1 }, -- Зелье бдительности 550
		}
	},
	permo_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0563', amount = 1, weight = 1 }, -- Аура внимательности 1200 (5% крита)
			{ id = 'g001ig0035', amount = 1, weight = 1 }, -- Великая аура жизненной силы 900 (30 ОЗ)
			{ id = 'g001ig0019', amount = 1, weight = 1 }, -- Малая аура вампиризма 900 (10% вампиризм)
			{ id = 'g001ig0506', amount = 1, weight = 1 }, -- Настойка оратора 1500 (+1 лидерство)
		}
	},
	staff = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig6017', amount = 1, weight = 1 }, -- Посох дневного света 700
		}
	},
}
--- Лут т5
Pools.loot.t5 = {
	heal = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.hres, amount = 6, weight = 1 },
			{ id = Items.heal.h75, amount = 3, weight = 1, group_amount = 2  },
			{ id = Items.heal.h100, amount = 10, weight = 1 },
			{ id = Items.heal.h200, amount = 2, weight = 1 },
		}
	},
	gold_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.gold.g200, amount = 1, weight = 1 },
			{ id = Items.gold.g250, amount = 1, weight = 1 },
			{ id = Items.gold.g300, amount = 1, weight = 1 },
		}
	},
	gold_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.gold.g250, amount = 1, weight = 1 },
			{ id = Items.gold.g300, amount = 1, weight = 1 },
			{ id = Items.gold.g350, amount = 1, weight = 1 },
		}
	},
	gold_3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.gold.g300, amount = 1, weight = 1 },
			{ id = Items.gold.g400, amount = 1, weight = 1 },
			{ id = Items.gold.g500, amount = 1, weight = 1 },
		}
	},
	art = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0182', amount = 1, weight = 1 }, -- Счастливая кость (Артефакт) 500
			{ id = 'g000ig2002', amount = 1, weight = 1 }, -- Святая чаша (Артефакт) 500
		}
	},
	boots = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0111', amount = 1, weight = 1 }, -- Сапоги ассасина 650
			{ id = 'g001ig0114', amount = 1, weight = 1 }, -- Тяжелые сапоги 500
		}
	},
	banner = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig1001', amount = 1, weight = 1 }, -- Знамя защиты 500
			{ id = 'g000ig1003', amount = 1, weight = 1 }, -- Знамя сражения 400
		}
	},
	relic = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0099', amount = 1, weight = 1 }, -- Перчатки дуэлянта (Реликвия) 500
			{ id = 'g000ig3020', amount = 1, weight = 1 }, -- Череп Танатоса (Реликвия) 500
			{ id = 'g001ig0421', amount = 1, weight = 1 }, -- Борода Имира (Реликвия) 500
		}
	},
	staff = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig6008', amount = 1, weight = 1 }, -- Посох невидимости 550
		}
	},
	aura_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0021', amount = 1, weight = 1 }, -- Аура слепой ярости 1200 (10% урона)
			{ id = 'g001ig0024', amount = 1, weight = 1 }, -- Аура защиты 1200 (10 брони)
			{ id = 'g001ig0025', amount = 1, weight = 1 }, -- Аура живучести 1200 (10% ОЗ)
			{ id = 'g001ig0031', amount = 1, weight = 1 }, -- Аура точности 1200 (15% точности)
			{ id = 'g001ig0563', amount = 1, weight = 1 }, -- Аура внимательности 1200 (5% крита)
		}
	},
	aura_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0022', amount = 1, weight = 1 }, -- Аура меткости 600 (10% точности)
			{ id = 'g001ig0027', amount = 1, weight = 1 }, -- Аура брони 700 (5 брони)
			{ id = 'g001ig0028', amount = 1, weight = 1 }, -- Аура выносливости 700 (5% ОЗ)
			{ id = 'g001ig0029', amount = 1, weight = 1 }, -- Аура силы 600 (5% урона)
		}
	},
	orb = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g000ig9025', amount = 1, weight = 1 }, -- Сфера Алчности 900
			{ id = 'g001ig0459', amount = 1, weight = 1 }, -- Сфера Землетрясения 900
			{ id = 'g001ig0477', amount = 1, weight = 1 }, -- Сфера Терзаний 900
			{ id = 'g000ig9027', amount = 1, weight = 1 }, -- Сфера Урагана 900
			{ id = 'g000ig9032', amount = 1, weight = 1 }, -- Сфера Цунами 900
			{ id = 'g000ig9006', amount = 1, weight = 1 }, -- Сфера Окаменения 1200
			{ id = 'g000ig9039', amount = 1, weight = 1 }, -- Сфера Паралича 1200
		}
	},
	scroll = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0078', amount = 1, weight = 1 }, -- Свиток "Призыв IV: Стихийный голем" 550
			{ id = 'g000ig5091', amount = 1, weight = 1 }, -- Свиток "Tempus status" 700
			{ id = 'g000ig5055', amount = 1, weight = 1 }, -- Свиток "Tortio menta" 700
			{ id = 'g000ig5115', amount = 1, weight = 1 }, -- Свиток "Проклятие Галеана" 700
			{ id = 'g001ig0586', amount = 1, weight = 1 }, -- Свиток "Предательство" 700
			{ id = 'g000ig5017', amount = 1, weight = 1 }, -- Свиток "Призыв к оружию" 700
			{ id = 'g000ig5035', amount = 1, weight = 1 }, -- Свиток "Стойкость" 700
			{ id = 'g000ig5114', amount = 1, weight = 1 }, -- Свиток "Знак Таладриэль" 700
		}
	},
}

------------------------------------------------------------------------------------------------------------------------
--- Предметы -> Руины
Pools.items.ruins = {}
------------------------------------------------------------------------------------------------------------------------
--- Руины т0
Pools.items.ruins.t0 = {
	priority = PoolPriority.AS_POSSIBLE,
	items = {
		{ id = 'g000ig3017', amount = 1, weight = 1, type = Item.Weapon }, -- Кинжал Вампиризма (Артефакт) 550
		{ id = 'g001ig0182', amount = 1, weight = 1, type = Item.Weapon }, -- Счастливая кость (Артефакт) 500
		{ id = 'g001ig0609', amount = 1, weight = 1, type = Item.Armor }, -- Загробный фонарь (Артефакт) 400
		{ id = 'g000ig2002', amount = 1, weight = 1, type = Item.Armor }, -- Святая чаша (Артефакт) 500
		{ id = 'g001ig0048', amount = 1, weight = 1, type = Item.Armor }, -- Амулет Кракена (Артефакт) 375
		{ id = 'g000ig1005', amount = 1, weight = 1, type = Item.Banner }, -- Знамя быстроты 550
		{ id = 'g001ig0051', amount = 1, weight = 1, type = Item.Banner }, -- Знамя выносливости 400
		{ id = 'g000ig1001', amount = 1, weight = 1, type = Item.Banner }, -- Знамя защиты 500
		{ id = 'g000ig1007', amount = 1, weight = 1, type = Item.Banner }, -- Знамя силы 400
		{ id = 'g000ig1003', amount = 1, weight = 1, type = Item.Banner }, -- Знамя сражения 400
		{ id = 'g001ig0493', amount = 1, weight = 1, type = Item.Jewel}, -- Книга божественных даров 400
		{ id = 'g001ig0494', amount = 1, weight = 1, type = Item.Jewel }, -- Книга странника 400
		{ id = 'g001ig0495', amount = 1, weight = 1, type = Item.Jewel }, -- Книга наследия 400
		{ id = 'g001ig0428', amount = 1, weight = 1, type = Item.Jewel }, -- Кожаные эльфийские доспехи (Реликвия) 400
		{ id = 'g001ig0426', amount = 1, weight = 1, type = Item.Jewel }, -- Куртка капитана (Реликвия) 400
		{ id = 'g000ig4007', amount = 1, weight = 1, type = Item.Jewel }, -- Медицинский трактат 500
		{ id = 'g001ig0605', amount = 1, weight = 1, type = Item.Jewel }, -- Книга постижения 600
		{ id = 'g001ig0114', amount = 1, weight = 1, type = Item.TravelItem }, -- Тяжелые сапоги 500
		{ id = 'g000ig1010', amount = 1, weight = 1, type = Item.TravelItem }, -- Эльфийские сапоги 700
		{ id = 'g000ig1011', amount = 1, weight = 1, type = Item.TravelItem }, -- Сапоги мореплавателя 800
	}
}
--- Руины т1
Pools.items.ruins.t1 = {
	priority = PoolPriority.AS_POSSIBLE,
	items = {
		{ id = 'g000ig3002', amount = 1, weight = 1, type = Item.Weapon }, -- Дьявольская чаша (Артефакт) 650
		{ id = 'g001ig0487', amount = 1, weight = 1, type = Item.Weapon }, -- Кольцо темных искуств (Артефакт) 800
		{ id = 'g001ig0417', amount = 1, weight = 1, type = Item.Weapon }, -- Руна верности Моккуркальфи (Артефакт) 800
		{ id = 'g001ig0582', amount = 1, weight = 1, type = Item.Armor }, -- Камень врат (Артефакт) 600
		{ id = 'g001ig0559', amount = 1, weight = 1, type = Item.Armor }, -- Руна благоволения Тиу (Артефакт) 700
		{ id = 'g001ig0594', amount = 1, weight = 1, type = Item.Armor }, -- Щит телохранителя (Артефакт) 700
		{ id = 'g001ig0557', amount = 1, weight = 1, type = Item.Armor }, -- Рог непреклонности (Артефакт) 700
		{ id = 'g001ig0047', amount = 1, weight = 1, type = Item.Armor }, -- Руна Жизни (Артефакт) 800
		{ id = 'g001ig0416', amount = 1, weight = 1, type = Item.Armor }, -- Руна предвидения Вотана (Артефакт) 800
		{ id = 'g000ig3022', amount = 1, weight = 1, type = Item.Jewel }, -- Лютня Очарования (Реликвия) 650
		{ id = 'g001ig0427', amount = 1, weight = 1, type = Item.Jewel }, -- Нагрудник Стража (Реликвия) 600
		{ id = 'g001ig0370', amount = 1, weight = 1, type = Item.Banner }, -- Знамя искоренителя ереси 600
		{ id = 'g001ig0369', amount = 1, weight = 1, type = Item.Banner }, -- Знамя снежной охоты 600
		{ id = 'g001ig0142', amount = 1, weight = 1, type = Item.Banner }, -- Знамя магии Воды 700
		{ id = 'g001ig0140', amount = 1, weight = 1, type = Item.Banner }, -- Знамя магии Воздуха 700
		{ id = 'g001ig0141', amount = 1, weight = 1, type = Item.Banner }, -- Знамя магии Земли 700
		{ id = 'g001ig0139', amount = 1, weight = 1, type = Item.Banner }, -- Знамя магии Огня 700
		{ id = 'g001ig0145', amount = 1, weight = 1, type = Item.Banner }, -- Знамя магии Разума 700
		{ id = 'g001ig0143', amount = 1, weight = 1, type = Item.Banner }, -- Знамя магии Смерти 700
		{ id = 'g001ig0114', amount = 1, weight = 1, type = Item.TravelItem }, -- Тяжелые сапоги 500
		{ id = 'g001ig0111', amount = 1, weight = 1, type = Item.TravelItem }, -- Сапоги ассасина 650
		{ id = 'g000ig1010', amount = 1, weight = 1, type = Item.TravelItem }, -- Эльфийские сапоги 700
		{ id = 'g000ig8003', amount = 1, weight = 1, type = Item.TravelItem }, -- Сапоги скорости 700
		{ id = 'g001ig0606', amount = 1, weight = 1, type = Item.TravelItem }, -- Сапоги родных земель 1000
	}
}
--- Руины т2
Pools.items.ruins.t2 = {
	priority = PoolPriority.AS_POSSIBLE,
	items = {
		{ id = 'g000ig3003', amount = 1, weight = 1, type = Item.Weapon }, -- Кольцо силы (Артефакт) 800
		{ id = 'g001ig0487', amount = 1, weight = 1, type = Item.Weapon }, -- Кольцо темных искуств (Артефакт) 800
		{ id = 'g001ig0173', amount = 1, weight = 1, type = Item.Weapon }, -- Пояс травницы (Артефакт) 800
		{ id = 'g001ig0196', amount = 1, weight = 1, type = Item.Weapon }, -- Рунный молот (Артефакт) 725
		{ id = 'g000ig9137', amount = 1, weight = 1, type = Item.Weapon }, -- Сердце Имира (Артефакт) 800
		{ id = 'g001ig0045', amount = 1, weight = 1, type = Item.Armor }, -- Кровь святого (Артефакт) 800
		{ id = 'g000ig2003', amount = 1, weight = 1, type = Item.Armor }, -- Наручи с черепом (Артефакт) 800
		{ id = 'g001ig0558', amount = 1, weight = 1, type = Item.Armor }, -- Рог возмездия (Артефакт) 700
		{ id = 'g001ig0589', amount = 1, weight = 1, type = Item.Armor }, -- Щит неведения (Артефакт) 800
		{ id = 'g001ig0591', amount = 1, weight = 1, type = Item.Armor }, -- Щит отражения (Артефакт) 900
		{ id = 'g001ig0420', amount = 1, weight = 1, type = Item.Jewel }, -- Вечные латы (Реликвия) 800
		{ id = 'g001ig0104', amount = 1, weight = 1, type = Item.Jewel }, -- Зуб людоеда (Реликвия) 800
		{ id = 'g001ig0422', amount = 1, weight = 1, type = Item.Jewel }, -- Кровавый покров (Реликвия) 700
		{ id = 'g001ig0423', amount = 1, weight = 1, type = Item.Jewel }, -- Латы Спасителя (Реликвия) 700
		{ id = 'g000ig2006', amount = 1, weight = 1, type = Item.Jewel }, -- Тиара чистоты (Реликвия) 800
		{ id = 'g001ig0037', amount = 1, weight = 1, type = Item.Jewel }, -- Шлем проклятого (Реликвия) 800
		{ id = 'g001ig0293', amount = 1, weight = 1, type = Item.Banner }, -- Баннер неудержимых 775
		{ id = 'g000ig1004', amount = 1, weight = 1, type = Item.Banner }, -- Знамя битвы 700
		{ id = 'g001ig0361', amount = 1, weight = 1, type = Item.Banner }, -- Знамя горна 700
		{ id = 'g001ig0289', amount = 1, weight = 1, type = Item.Banner }, -- Знамя городских стражей 700
		{ id = 'g001ig0363', amount = 1, weight = 1, type = Item.Banner }, -- Знамя отваги 750
		{ id = 'g001ig0588', amount = 0, weight = 1, type = Item.Banner }, -- Знамя тысячи битв 750
		{ id = 'g000ig1008', amount = 1, weight = 1, type = Item.Banner }, -- Знамя энергии 700
		{ id = 'g001ig0365', amount = 1, weight = 1, type = Item.Banner }, -- Ловец Кошмаров 700
		{ id = 'g001ig0292', amount = 1, weight = 1, type = Item.Banner }, -- Стяг концентрации 700
		{ id = 'g001ig0367', amount = 1, weight = 1, type = Item.Banner }, -- Стяг чумных воинств 700
		{ id = 'g001ig0111', amount = 1, weight = 1, type = Item.TravelItem }, -- Сапоги ассасина 650
		{ id = 'g000ig8003', amount = 1, weight = 1, type = Item.TravelItem }, -- Сапоги скорости 700
		{ id = 'g001ig0606', amount = 1, weight = 1, type = Item.TravelItem }, -- Сапоги родных земель 1000
	}
}
--- Руины т3
Pools.items.ruins.t3 = {
	r1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0124', amount = 1, weight = 1 }, -- Клинок Возвышенного (Артефакт) 1000
			{ id = 'g001ig0042', amount = 1, weight = 1 }, -- Клыки Бездны (Артефакт) 950
			{ id = 'g001ig0612', amount = 1, weight = 1 }, -- Кольцо небесной воли (Артефакт) 1000
			--{ id = 'g001ig0592', amount = 0, weight = 1 }, -- Монолитный щит (Артефакт) 1200
			{ id = 'g002ig0019', amount = 1, weight = 1 }, -- Осадный щит (Артефакт) 1000
			{ id = 'g001ig0040', amount = 1, weight = 1 }, -- Перстень песков (Артефакт) 1000
			--{ id = 'g000ig2004', amount = 0, weight = 1 }, -- Рог всеведенья (Артефакт) 1200
			--{ id = 'g001ig0044', amount = 0, weight = 1 }, -- Сердце океана (Артефакт) 1200
			--{ id = 'g001ig0060', amount = 0, weight = 1 }, -- Тысяча чешуек (Артефакт) 1200
			--{ id = 'g001ig0158', amount = 0, weight = 1 }, -- Ужасающий топор (Артефакт) 1200
			{ id = 'g001ig0041', amount = 1, weight = 1 }, -- Череп шамана (Артефакт) 1000
			--{ id = 'g001ig0590', amount = 0, weight = 1 }, -- Щит Мизраэля (Артефакт) 1200
			{ id = 'g001ig0071', amount = 1, weight = 1 }, -- Эльфийская брошь (Артефакт) 1000
		}
	},
	r2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			--{ id = 'g001ig0174', amount = 0, weight = 1 }, -- Божественный потир (Артефакт) 1200
			{ id = 'g000ig3019', amount = 1, weight = 1 }, -- Клинок Танатоса (Артефакт) 1150
			{ id = 'g001ig0413', amount = 1, weight = 1 }, -- Корни триббога (Артефакт) 1200
			{ id = 'g001ig0197', amount = 1, weight = 1 }, -- Проклятый пепел (Артефакт) 950
			{ id = 'g001ig0415', amount = 1, weight = 1 }, -- Руна кары Тьяцци (Артефакт) 1150
			{ id = 'g000ig3004', amount = 1, weight = 1 }, -- Рунический клинок (Артефакт) 1200
			{ id = 'g000ig9035', amount = 1, weight = 1 }, -- Слеза Мортис (Артефакт) 1200
			{ id = 'g001ig0657', amount = 1, weight = 1 }, -- Топор палача (Артефакт) 1000
			{ id = 'g001ig0155', amount = 1, weight = 1 }, -- Благословенный браслет (Артефакт) 1400
		}
	},
	r3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0424', amount = 1, weight = 1 }, -- Длани ангела (Реликвия) 1000
			{ id = 'g001ig0425', amount = 1, weight = 1 }, -- Кафтан первооткрывателя (Реликвия) 900
			{ id = 'g001ig0597', amount = 0, weight = 1 }, -- Кираса резонанса (Реликвия) 1000
			{ id = 'g000ig3005', amount = 1, weight = 1 }, -- Корона Мьолнира (Реликвия) 1200
			--{ id = 'g001ig0539', amount = 0, weight = 1 }, -- Тисовый лук (Реликвия) 900
			{ id = 'g001ig0156', amount = 1, weight = 1 }, -- Шкатулка предсказаний (Реликвия) 1050
			{ id = 'g001ig0419', amount = 1, weight = 1 }, -- Шлем воителя (Реликвия) 1000
		}
	},
	r4 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0362', amount = 1, weight = 1 }, -- Знамя болот 950
			{ id = 'g001ig0364', amount = 1, weight = 1 }, -- Знамя ветра перемен 900
			--{ id = 'g002ig0021', amount = 0, weight = 1 }, -- Знамя двойственной судьбы 900
			{ id = 'g001ig0375', amount = 1, weight = 1 }, -- Знамя наследия 1000
			{ id = 'g001ig0359', amount = 1, weight = 1 }, -- Знамя неизбежности 1000
			{ id = 'g001ig0357', amount = 1, weight = 1 }, -- Знамя неистовства 850
			{ id = 'g000ig1002', amount = 1, weight = 1 }, -- Знамя неуязвимости 850
			{ id = 'g001ig0358', amount = 1, weight = 1 }, -- Знамя ража 950
			{ id = 'g000ig1006', amount = 1, weight = 1 }, -- Знамя скорости 925
			{ id = 'g001ig0374', amount = 1, weight = 1 }, -- Знамя стального листопада 900
		}
	},
}
--- Руины т4-т5
Pools.items.ruins.t4 = {
	r1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0174', amount = 1, weight = 2 }, -- Божественный потир (Артефакт) 1200
			{ id = 'g001ig0411', amount = 1, weight = 2 }, -- Грань реальности (Артефакт) 1400
			{ id = 'g001ig0410', amount = 1, weight = 2 }, -- Дьявольская булава (Артефакт) 1500
			{ id = 'g000ig3019', amount = 1, weight = 2 }, -- Клинок Танатоса (Артефакт) 1150
			{ id = 'g001ig0413', amount = 1, weight = 2 }, -- Корни триббога (Артефакт) 1200
			{ id = 'g001ig0415', amount = 1, weight = 2 }, -- Руна кары Тьяцци (Артефакт) 1150
			{ id = 'g000ig3004', amount = 1, weight = 2 }, -- Рунический клинок (Артефакт) 1200
			{ id = 'g000ig9035', amount = 1, weight = 2 }, -- Слеза Мортис (Артефакт) 1200
			{ id = 'g001ig0585', amount = 1, weight = 2 }, -- Кольцо создателя (Артефакт) 1400
			{ id = 'g001ig0046', amount = 1, weight = 2 }, -- Кровь Владыки (Артефакт) 1400
			{ id = 'g001ig0592', amount = 1, weight = 2 }, -- Монолитный щит (Артефакт) 1200
			{ id = 'g000ig2004', amount = 1, weight = 2 }, -- Рог всеведенья (Артефакт) 1200
			{ id = 'g001ig0060', amount = 1, weight = 2 }, -- Тысяча чешуек (Артефакт) 1200
			{ id = 'g001ig0590', amount = 1, weight = 2 }, -- Щит Мизраэля (Артефакт) 1200
			{ id = 'g001ig0179', amount = 1, weight = 2 }, -- Боевая коса (Артефакт) 1750
			{ id = 'g000ig3005', amount = 1, weight = 2 }, -- Корона Мьолнира (Реликвия) 1200
			{ id = 'g001ig0116', amount = 1, weight = 2 }, -- Пластинчатый доспех (Реликвия) 1550
			{ id = 'g001ig0596', amount = 1, weight = 1 }, -- Линарет (Реликвия) 1250
			{ id = 'g001ig0360', amount = 1, weight = 2 }, -- Стяг упырей 1300
			{ id = 'g000ig9043', amount = 1, weight = 2 }, -- Сфера ярости 1000
		}
	},
}

------------------------------------------------------------------------------------------------------------------------
--- Предметы -> Сундуки
Pools.items.bags = {}
------------------------------------------------------------------------------------------------------------------------
--- Сундуки т0
Pools.items.bags.t0 = {
	heal_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.h25, amount = 1, weight = 1, group_amount = 2 },
			{ id = Items.heal.h50, amount = 1, weight = 1 },
		}
	},
	heal_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.hres, amount = 1, weight = 1 },
			{ id = Items.heal.h100, amount = 1, weight = 1 },
		}
	},
	gold = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.gold.g50, amount = 1, weight = 1 },
		}
	}
}
--- Сундуки т1
Pools.items.bags.t1 = {
	heal_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.h25, amount = 1, weight = 1, group_amount = 3 },
			{ id = Items.heal.h75, amount = 1, weight = 1 },
		}
	},
	heal_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.hres, amount = 1, weight = 1 },
			{ id = Items.heal.h100, amount = 1, weight = 1 },
		}
	},
	gold = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.gold.g50, amount = 1, weight = 1, group_amount = 2 },
			{ id = Items.gold.g100, amount = 1, weight = 1 },
		}
	},
}
--- Сундуки т2
Pools.items.bags.t2 = {
	heal_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.h50, amount = 1, weight = 1, group_amount = 2 },
			{ id = Items.heal.h100, amount = 1, weight = 1 },
		}
	},
	heal_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.hres, amount = 1, weight = 1 },
			{ id = Items.heal.h100, amount = 1, weight = 1 },
		}
	},
	gold = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.gold.g50, amount = 1, weight = 1, group_amount = 3 },
			{ id = Items.gold.g75, amount = 1, weight = 1, group_amount = 2 },
			{ id = Items.gold.g150, amount = 1, weight = 1 },
		}
	},
}
--- Сундуки т3
Pools.items.bags.t3 = {
	heal_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.h25, amount = 1, weight = 1, group_amount = 4 },
			{ id = Items.heal.h100, amount = 1, weight = 1 },
			{ id = Items.heal.hres, amount = 1, weight = 1 },
		}
	},
	gold = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.gold.g50, amount = 1, weight = 1, group_amount = 2 },
			{ id = Items.gold.g100, amount = 1, weight = 1 },
		}
	},
}
--- Сундуки т5
Pools.items.bags.t5 = {
	heal_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.heal.h200, amount = 1, weight = 1 },
			{ id = Items.heal.hres, amount = 1, weight = 1 },
		}
	},
	gold = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Items.gold.g100, amount = 1, weight = 1, group_amount = 2 },
			{ id = Items.gold.g200, amount = 1, weight = 1 },
		}
	},
	permo_1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0307', amount = 2, weight = 1 }, -- Зелье стойкости 450 (+5 брони)
			{ id = 'g001ig0309', amount = 2, weight = 1 }, -- Эликсир задиры 400 (+5% инициативы)
			{ id = 'g001ig0311', amount = 2, weight = 1 }, -- Эликсир хладнокровия 400 (+5% точности)
			{ id = 'g001ig0313', amount = 2, weight = 1 }, -- Эликсир совершенствования 400 (+5% урона)
			{ id = 'g001ig0315', amount = 2, weight = 1 }, -- Зелье великана 400 (+5% ОЗ)
		}
	},
	permo_2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'g001ig0328', amount = 1, weight = 1 }, -- Эликсир ледяной плоти 400 (мороз)
			{ id = 'g001ig0330', amount = 1, weight = 1 }, -- Эликсир Неопалимых 400 (ожог)
			{ id = 'g001ig0332', amount = 1, weight = 1 }, -- Зелье ихора Танатоса 400 (яд)
			{ id = 'g001ig0342', amount = 1, weight = 1 }, -- Эликсир норн 400 (страх)
			{ id = 'g001ig0344', amount = 1, weight = 1 }, -- Эликсир предназначения 400 (замедление)
			{ id = 'g001ig0346', amount = 1, weight = 1 }, -- Эликсир неудержимости 400 (ослабление)
			{ id = 'g001ig0354', amount = 1, weight = 1 }, -- Жидкий металл Уру 450 (РБ)
		}
	}
}

------------------------------------------------------------------------------------------------------------------------
--- Заклинания
Pools.spells = {}
------------------------------------------------------------------------------------------------------------------------
--- Столица
Pools.spells.capital = {
	priority = PoolPriority.AS_POSSIBLE,
	items = {
		{ id = Spells.g000ss0002, weight = 1, races = {Race.Human} },
		{ id = Spells.g000ss0003, weight = 1, races = {Race.Human} },
		{ id = Spells.g000ss0004, weight = 1, races = {Race.Human} },
		{ id = Spells.g000ss0009, weight = 1, races = {Race.Human} },

		{ id = Spells.g000ss0021, weight = 1, races = {Race.Dwarf} },
		{ id = Spells.g000ss0023, weight = 1, races = {Race.Dwarf} },
		{ id = Spells.g000ss0024, weight = 1, races = {Race.Dwarf} },
		{ id = Spells.g000ss0025, weight = 1, races = {Race.Dwarf} },

		{ id = Spells.g000ss0061, weight = 1, races = {Race.Undead} },
		{ id = Spells.g000ss0062, weight = 1, races = {Race.Undead} },
		{ id = Spells.g000ss0064, weight = 1, races = {Race.Undead} },
		{ id = Spells.g000ss0065, weight = 1, races = {Race.Undead} },

		{ id = Spells.g000ss0041, weight = 1, races = {Race.Heretic} },
		{ id = Spells.g000ss0042, weight = 1, races = {Race.Heretic} },
		{ id = Spells.g000ss0043, weight = 1, races = {Race.Heretic} },
		{ id = Spells.g000ss0044, weight = 1, races = {Race.Heretic} },

		{ id = Spells.g000ss0097, weight = 1, races = {Race.Elf} },
		{ id = Spells.g000ss0098, weight = 1, races = {Race.Elf} },
		{ id = Spells.g000ss0101, weight = 1, races = {Race.Elf} },
		{ id = Spells.g000ss0106, weight = 1, races = {Race.Elf} },
	}
}
--- Башня мага т1
Pools.spells.t1 = {
	list = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Spells.g000ss0002, weight = 1 },
			{ id = Spells.g000ss0007, weight = 1 },
			{ id = Spells.g000ss0178, weight = 1 },
			{ id = Spells.g000ss0023, weight = 1 },
			{ id = Spells.g000ss0179, weight = 1 },
			{ id = Spells.g000ss0045, weight = 1 },
			{ id = Spells.g000ss0044, weight = 1 },
			{ id = Spells.g000ss0134, weight = 1 },
			{ id = Spells.g000ss0064, weight = 1 },
			{ id = Spells.g000ss0101, weight = 1 },
			{ id = Spells.g000ss0102, weight = 1 },
			{ id = Spells.g000ss0183, weight = 1 },
			{ id = Spells.g000ss0197, weight = 1 },
			{ id = Spells.g000ss0131, weight = 1 },
			{ id = Spells.g000ss0029, weight = 1 },
			{ id = Spells.g000ss0184, weight = 1 },
			{ id = Spells.g000ss0034, weight = 1 },
			{ id = Spells.g000ss0050, weight = 1 },
			{ id = Spells.g000ss0185, weight = 1 },
			{ id = Spells.g000ss0186, weight = 1 },
			{ id = Spells.g000ss0069, weight = 1 },
			{ id = Spells.g000ss0124, weight = 1 },
			{ id = Spells.g000ss0187, weight = 1 },
			{ id = Spells.g000ss0133, weight = 1 },
			{ id = Spells.g000ss0107, weight = 1 },
		}
	},
	summons = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Spells.g000ss0025, weight = 1, races = {Race.Human, Race.Undead, Race.Heretic, Race.Elf} },
			{ id = Spells.g000ss0061, weight = 1, races = {Race.Human, Race.Dwarf, Race.Heretic, Race.Elf} },
			{ id = Spells.g000ss0041, weight = 1, races = {Race.Human, Race.Dwarf, Race.Undead, Race.Elf} },
			{ id = Spells.g000ss0098, weight = 1, races = {Race.Human, Race.Dwarf, Race.Undead, Race.Heretic} },
		}
	},
	iad = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = Spells.g000ss0188, weight = 1 },
		}
	}
}
--- Башня мага т3
Pools.spells.t3 = {
	list = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Spells.g000ss0013, weight = 1 },
			{ id = Spells.g000ss0026, weight = 1 },
			{ id = Spells.g000ss0089, weight = 1 },
			{ id = Spells.g000ss0074, weight = 1 },
			{ id = Spells.g000ss0082, weight = 1 },
			{ id = Spells.g000ss0114, weight = 1 },

			{ id = Spells.g000ss0012, weight = 1 },
			{ id = Spells.g000ss0199, weight = 1 },
			{ id = Spells.g000ss0073, weight = 1 },
			{ id = Spells.g000ss0111, weight = 1 },
			{ id = Spells.g000ss0115, weight = 1 },
			{ id = Spells.g000ss0116, weight = 1 },
		}
	},
	antiwards = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Spells.g000ss0207, weight = 1 },
			{ id = Spells.g000ss0208, weight = 1 },
			{ id = Spells.g000ss0206, weight = 1 },
			{ id = Spells.g000ss0209, weight = 1 },
		}
	},
	wards = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Spells.g000ss0005, weight = 1 },
			{ id = Spells.g000ss0001, weight = 1 },
			{ id = Spells.g000ss0010, weight = 1 },
			{ id = Spells.g000ss0016, weight = 1 },
			{ id = Spells.g000ss0011, weight = 1 },
			{ id = Spells.g000ss0018, weight = 1 },
			{ id = Spells.g000ss0079, weight = 1 },
			{ id = Spells.g000ss0039, weight = 1 },
		}
	},
	summons = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = Spells.g000ss0108, weight = 1 },
			{ id = Spells.g000ss0071, weight = 1 },
			{ id = Spells.g000ss0031, weight = 1 },
		}
	},
	special = {
		priority = PoolPriority.ALL,
		items = {
			{ id = Spells.g000ss0145, weight = 100 },
			{ id = Spells.g000ss0107, weight = 100 },
			{ id = Spells.g000ss0027, weight = 1 },
		}
	}
}

------------------------------------------------------------------------------------------------------------------------
--- Объекты
Pools.objects = {}
------------------------------------------------------------------------------------------------------------------------
--- Руины
Pools.objects.ruins = {
	t0 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = '33 страницы свода правил' }, weight = 1 },
			{ data = { name = 'Псковская голубая порно устрица "Сраная руина"' }, weight = 1 },
			{ data = { name = 'Аптека "2 сатира"' }, weight = 1 },
		}
	},
	t1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = 'Одно слово - Чеченец! Так он Белорус! Да? Какая разница?' }, weight = 1 },
			{ data = { name = 'Шахматный клуб "Programmer Helix"' }, weight = 1 },
			{ data = { name = 'Гараж Вадим Палыча. На стене изображен когтистый медведь, ниже надпись: "Не беспокоить, Ивана нет", подпись: "Евгений"' }, weight = 1 },
		}
	},
	t2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = 'Логово Бехолдера.Вход без Хренотонометра запрещен!' }, weight = 1 },
		}
	},
	t3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = 'Ифритский уголок' }, weight = 1 },
			{ data = { name = "Замок-кузня Kowka'Mare" }, weight = 1 },
			{ data = { name = 'Древневавилонская таверна "Некситель"' }, weight = 1 },
			{ data = { name = 'Пиратский Гронт. Над входом табличка: заходи, у нас Nice Kok' }, weight = 1 },
			{ data = { name = 'Старая пивоварня Ивана' }, weight = 1 },
			{ data = { name = 'Без негатива' }, weight = 1 },
			{ data = { name = 'Protoss Bone Nexus' }, weight = 1 },
			{ data = { name = "Неприступный данжен Reign'o'Van" }, weight = 1 },
			{ data = { name = "Сокровищница НеВерМора (бота)" }, weight = 1 },
		}
	},
	t4 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = 'БИТВА ЗА КОСАРИК!' }, weight = 1 },
			{ data = { name = 'УЛЬТРА ДРЕВНЕЕ КИТАЙСКОЕ ПРОКЛЯТИЕ НА ЗАЛИВКУ В ЭТИХ РУИНАХ' }, weight = 1 },
		}
	},
	t5 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = '' }, weight = 1 },
		}
	},
}
--- Столица
Pools.objects.capitals = {
	t0 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = '' }, weight = 1 },
		}
	},
}
--- Город
Pools.objects.towns = {
	t1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = 'Гусь-Хрустальный' }, weight = 1 },
			{ data = { name = 'БээРБэГэйск' }, weight = 1 },
		}
	},
	t2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = 'СУЗдаль' }, weight = 1 },
			{ data = { name = 'деревня простых парней' }, weight = 1 },
			{ data = { name = 'ДвойноДонск' }, weight = 1 },
		}
	},
	t4 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = 'Cтримерск' }, weight = 1 },
		}
	},
}
--- Лавка торговца
Pools.objects.merchants = {
	t1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = 'Лавка "Летящий дракон"', description = 'Мало что происходит в этом городе без моего ведома. Лао Чу' }, weight = 1 },
			{ data = { name = 'Мельница Пешека', description = 'Сначала монеты, потом мораль' }, weight = 1 },
			{ data = { name = 'Таверна РокВолка', description = 'У нас тут творческий коллектив. Можем спеть, сыграть, нарисовать... ну или нахер вас послать!' }, weight = 1 },
			{ data = { name = "Kids'Staves", description = 'Заходи, найдешь посох по душе!' }, weight = 1 },
		}
	},
	t2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = 'Клиника по борьбе с расстройствами пищевого поведения', description = 'В животе живой паук - вас спасет доктор наук!' }, weight = 1 },
			{ data = { name = 'Песочница Дзаро', description = 'Сюрикены, Расенганы, сеансы Нарутотерапии' }, weight = 1 },
		}
	},
	t3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = 'Гастрономический бутик', description = 'Продаются продукты со всего мира! Гордость нашей лавки особый вид макарон - фетучини' }, weight = 1 },
			{ data = { name = 'Магазин Сатонира', description = 'У меня лучший CUMпот в округе!' }, weight = 1 },
		}
	},
}
--- Башня мага
Pools.objects.mages = {
	t1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = 'Филармония бардов "Уфа"', description = 'Мы сейчас репетируем. Отрабатываем мощнейший отвал башки в Дисах.' }, weight = 1 },
			{ data = { name = 'Тропа Модеуса', description = 'I strike da Doc and reach da top, fellas' }, weight = 1 },
		}
	},
	t3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = 'Столп Ученика', description = 'Настоящий мастер — это вечный ученик' }, weight = 1 },
			{ data = { name = 'у Хрусталя', description = 'Комментаторская вышка' }, weight = 1 },
		}
	}
}
--- Тренер
Pools.objects.trainers = {
	t3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = 'Самый Успешный Зал', description = 'ОтСУЗь своих врагов полностью' }, weight = 1 },
			{ data = { name = 'Лагерь Дедикейшена', description = 'Welcome to my GYM, buddy' }, weight = 1 },
		}
	}
}
--- Рынок ресурсов
Pools.objects.markets = {
	t4 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = 'Рынок ресурсов', description = 'Огромная вывеска на входе гласит "Верните Мака"' }, weight = 1 },
		}
	},
	tm = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = '', description = '' }, weight = 1 },
		}
	}
}
--- Лагерь наемников
Pools.objects.mercenaries = {
	t2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = 'Зоомагазин «Барсик»', description = 'Восьмое чудо света!', units = { id = 'g000uu5037', level = 1, unique = true } }, weight = 1 },
			{ data = { name = 'Аквариум', description = 'Бульк!', units = { id = 'g000uu5028', level = 1, unique = true } }, weight = 1 },
			{ data = { name = 'Вечнотренировочный лагерь "Новичок"', description = 'Наш говорящий пенистый паук все время зовет Наташу. Пожалуйста, найдите ее!', units = { id = 'g001uu8282', level = 1, unique = true } }, weight = 1 },
			{ data = { name = 'High-skill наемники"', description = 'У нас лучшие педальные кони', units = { id = 'g000uu7588', level = 1, unique = true } }, weight = 1 },
		}
	},
	t3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = 'Обессатиренный заповедник', description = 'Козлят нет, забрал доктор', units = {} }, weight = 1 },
		}
	},
	t5 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { name = 'Бюро по трудоустройству населения №1', description = 'Шаманка здесь и сейчас!', units = { id = 'g000uu8046', level = 1, unique = true } }, weight = 1 },
			{ data = { name = 'Бюро по трудоустройству населения №2', description = 'Шаманок нет, но есть кое кто..', units = { id = 'g000uu6104', level = 3, unique = true } }, weight = 1 },
		}
	}
}

------------------------------------------------------------------------------------------------------------------------
--- Наемники
Pools.mercenaries = {}
------------------------------------------------------------------------------------------------------------------------
--- т2
Pools.mercenaries.t2 = {
	m1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { id = 'g003uu5001', level = 1, unique = false }, weight = 1, races = { Race.Human } }, -- Боец ополчения 35
			{ data = { id = 'g000uu0001', level = 1, unique = false }, weight = 1, races = { Race.Human } }, -- Сквайр 35

			{ data = { id = 'g000uu0036', level = 1, unique = false }, weight = 1, races = { Race.Dwarf } }, -- Гном 35
			{ data = { id = 'g000uu0026', level = 1, unique = false }, weight = 1, races = { Race.Dwarf } }, -- Снежный волк 110

			{ data = { id = 'g000uu0086', level = 1, unique = false }, weight = 1, races = { Race.Undead } }, -- Мертвец 35
			{ data = { id = 'g001uu7539', level = 1, unique = false }, weight = 1, races = { Race.Undead } }, -- Колотун 35

			{ data = { id = 'g000uu0052', level = 1, unique = false }, weight = 1, races = { Race.Heretic } }, -- Одержимый 35
			{ data = { id = 'g000uu0062', level = 1, unique = false }, weight = 1, races = { Race.Heretic } }, -- Сектант 35

			{ data = { id = 'g000uu8014', level = 1, unique = false }, weight = 1, races = { Race.Elf } }, -- Кентавр-копейшик 35
			{ data = { id = 'g000uu8018', level = 1, unique = false }, weight = 1, races = { Race.Elf } }, -- Разведчик 35
		}
	},
	m2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { id = 'g003uu5002', level = 2, unique = true }, weight = 1, races = { Race.Human } }, -- Алебардист 220
			{ data = { id = 'g000uu0009', level = 2, unique = true }, weight = 1, races = { Race.Human } }, -- Волшебник 205
			{ data = { id = 'g000uu7561', level = 2, unique = true }, weight = 1, races = { Race.Human } }, -- Егерь 205
			{ data = { id = 'g000uu0012', level = 2, unique = true }, weight = 1, races = { Race.Human } }, -- Жрец 215
			{ data = { id = 'g000uu0016', level = 2, unique = true }, weight = 1, races = { Race.Human } }, -- Монахиня 215
			{ data = { id = 'g000uu2014', level = 2, unique = true }, weight = 1, races = { Race.Human } }, -- Оруженосец 215
			{ data = { id = 'g000uu0004', level = 2, unique = true }, weight = 1, races = { Race.Human } }, -- Охотник на ведьм 215
			{ data = { id = 'g000uu2029', level = 2, unique = true }, weight = 1, races = { Race.Human } }, -- Поборник 215
			{ data = { id = 'g000uu0007', level = 2, unique = true }, weight = 1, races = { Race.Human } }, -- Рейнджер 205
			{ data = { id = 'g000uu0002', level = 2, unique = true }, weight = 1, races = { Race.Human } }, -- Рыцарь 220
			{ data = { id = 'g000uu8310', level = 2, unique = true }, weight = 1, races = { Race.Human } }, -- Саггритар 215

			{ data = { id = 'g000uu0037', level = 2, unique = true }, weight = 1, races = { Race.Dwarf } }, -- Воин 245
			{ data = { id = 'g000uu0027', level = 2, unique = true }, weight = 1, races = { Race.Dwarf } }, -- Арбалетчик 225
			{ data = { id = 'g000uu0034', level = 2, unique = true }, weight = 1, races = { Race.Dwarf } }, -- Посвященная 210

			{ data = { id = 'g000uu7542', level = 2, unique = true }, weight = 1, races = { Race.Undead } }, -- Чумотворец 210
			{ data = { id = 'g000uu0087', level = 2, unique = true }, weight = 1, races = { Race.Undead } }, -- Зомби 220
			{ data = { id = 'g000uu0081', level = 2, unique = true }, weight = 1, races = { Race.Undead } }, -- Колдун 210
			{ data = { id = 'g000uu0079', level = 2, unique = true }, weight = 1, races = { Race.Undead } }, -- Призрак 210
			{ data = { id = 'g000uu0090', level = 2, unique = true }, weight = 1, races = { Race.Undead } }, -- Тамплиер 220
			{ data = { id = 'g003uu5013', level = 2, unique = true }, weight = 1, races = { Race.Undead } }, -- Череполом 230

			{ data = { id = 'g000uu0053', level = 2, unique = true }, weight = 1, races = { Race.Heretic } }, -- Берсеркер 230
			{ data = { id = 'g000uu0067', level = 2, unique = true }, weight = 1, races = { Race.Heretic } }, -- Ведьма 210
			{ data = { id = 'g000uu0063', level = 2, unique = true }, weight = 1, races = { Race.Heretic } }, -- Темный колдун 210

			{ data = { id = 'g000uu8015', level = 2, unique = true }, weight = 1, races = { Race.Elf } }, -- Кентавр-латник 255
			{ data = { id = 'g000uu8016', level = 2, unique = true }, weight = 1, races = { Race.Elf } }, -- Кентавр-странник 255
			{ data = { id = 'g000uu8032', level = 2, unique = true }, weight = 1, races = { Race.Elf } }, -- Оракул 225
			{ data = { id = 'g000uu8019', level = 2, unique = true }, weight = 1, races = { Race.Elf } }, -- Охотник 230
			{ data = { id = 'g000uu8022', level = 2, unique = true }, weight = 1, races = { Race.Elf } }, -- Сторож 230
			{ data = { id = 'g000uu8026', level = 2, unique = true }, weight = 1, races = { Race.Elf } }, -- Чанелер 205
		}
	},
	m3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { id = 'g000uu0003', level = 3, unique = true }, weight = 1, races = { Race.Human } }, -- Имперский рыцарь 715
			{ data = { id = 'g000uu0005', level = 3, unique = true }, weight = 1, races = { Race.Human } }, -- Инквизитор 775
			{ data = { id = 'g000uu2015', level = 3, unique = true }, weight = 1, races = { Race.Human } }, -- Страж Святости 695
			{ data = { id = 'g003uu5003', level = 3, unique = true }, weight = 1, races = { Race.Human } }, -- Ревнитель 765
			{ data = { id = 'g000uu8311', level = 3, unique = true }, weight = 1, races = { Race.Human } }, -- Ардет 855
			{ data = { id = 'g000uu2030', level = 3, unique = true }, weight = 1, races = { Race.Human } }, -- Детектив 715
			{ data = { id = 'g000uu0154', level = 3, unique = true }, weight = 1, races = { Race.Human } }, -- Ассасин 805
			{ data = { id = 'g000uu2009', level = 3, unique = true }, weight = 1, races = { Race.Human } }, -- Клинок в тени 805

			{ data = { id = 'g000uu0162', level = 3, unique = true }, weight = 1, races = { Race.Dwarf } }, -- Защитник горна 875
			{ data = { id = 'g000uu7568', level = 3, unique = true }, weight = 1, races = { Race.Dwarf } }, -- Сотрясатель 875
			{ data = { id = 'g006uu1128', level = 3, unique = true }, weight = 1, races = { Race.Dwarf } }, -- Мастер печи 875
			{ data = { id = 'g001uu7571', level = 2, unique = true }, weight = 1, races = { Race.Dwarf } }, -- Белый волк 710
			{ data = { id = 'g004uu8005', level = 2, unique = true }, weight = 1, races = { Race.Dwarf } }, -- Гарм 710

			{ data = { id = 'g000uu0082', level = 3, unique = true }, weight = 1, races = { Race.Undead } }, -- Некромант 710
			{ data = { id = 'g000uu0085', level = 3, unique = true }, weight = 1, races = { Race.Undead } }, -- Злой дух 810
			{ data = { id = 'g003uu5012', level = 3, unique = true }, weight = 1, races = { Race.Undead } }, -- Орк-палач 880
			{ data = { id = 'g000uu0088', level = 3, unique = true }, weight = 1, races = { Race.Undead } }, -- Скелет-воин 720
			{ data = { id = 'g000uu0091', level = 3, unique = true }, weight = 1, races = { Race.Undead } }, -- Лорд Тьмы 770
			{ data = { id = 'g000uu2007', level = 3, unique = true }, weight = 1, races = { Race.Undead } }, -- Мумификатор 860

			{ data = { id = 'g000uu0054', level = 3, unique = true }, weight = 1, races = { Race.Heretic } }, -- Черный паладин 630
			{ data = { id = 'g000uu2003', level = 3, unique = true }, weight = 1, races = { Race.Heretic } }, -- Мучитель 630
			{ data = { id = 'g000uu0064', level = 3, unique = true }, weight = 1, races = { Race.Heretic } }, -- Демонолог 760
			{ data = { id = 'g000uu0068', level = 3, unique = true }, weight = 1, races = { Race.Heretic } }, -- Колдунья 710

			{ data = { id = 'g001uu7579', level = 3, unique = true }, weight = 1, races = { Race.Elf } }, -- Кентавр-гвардеец 905
			{ data = { id = 'g000uu8027', level = 3, unique = true }, weight = 1, races = { Race.Elf } }, -- Архонт 730
			{ data = { id = 'g000uu8028', level = 3, unique = true }, weight = 1, races = { Race.Elf } }, -- Тиург 730
			{ data = { id = 'g000uu8020', level = 3, unique = true }, weight = 1, races = { Race.Elf } }, -- Стингер 830
			{ data = { id = 'g000uu8023', level = 3, unique = true }, weight = 1, races = { Race.Elf } }, -- Стражник 780
			{ data = { id = 'g000uu8024', level = 3, unique = true }, weight = 1, races = { Race.Elf } }, -- Часовой 780
		}
	},
	m4 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { id = 'g000uu7595', level = 2, unique = true }, weight = 1, races = { Race.Human } }, -- Рефаим 915
			{ data = { id = 'g000uu7562', level = 3, unique = true }, weight = 1, races = { Race.Human } }, -- Бореалис 805
			{ data = { id = 'g000uu0013', level = 3, unique = true }, weight = 1, races = { Race.Human } }, -- Священник 815
			{ data = { id = 'g000uu7569', level = 3, unique = true }, weight = 1, races = { Race.Human } }, -- Иерей 815
			{ data = { id = 'g000uu0017', level = 3, unique = true }, weight = 1, races = { Race.Human } }, -- Аббатиса 790
			{ data = { id = 'g000uu0010', level = 3, unique = true }, weight = 1, races = { Race.Human } }, -- Маг 705
			{ data = { id = 'g000uu0153', level = 3, unique = true }, weight = 1, races = { Race.Human } }, -- Ученик-элементалист 705
			{ data = { id = 'g001uu7581', level = 3, unique = true }, weight = 1, races = { Race.Human } }, -- Заклинатель 705

			{ data = { id = 'g000uu0038', level = 3, unique = true }, weight = 1, races = { Race.Dwarf } }, -- Ветеран 795
			{ data = { id = 'g000uu0041', level = 3, unique = true }, weight = 1, races = { Race.Dwarf } }, -- Горец 795
			{ data = { id = 'g000uu0035', level = 3, unique = true }, weight = 1, races = { Race.Dwarf } }, -- Друид 710
			{ data = { id = 'g000uu0161', level = 3, unique = true }, weight = 1, races = { Race.Dwarf } }, -- Алхимик 710
			{ data = { id = 'g000uu7558', level = 3, unique = true }, weight = 1, races = { Race.Dwarf } }, -- Исса 710
			{ data = { id = 'g000uu0030', level = 2, unique = true }, weight = 5, races = { Race.Dwarf } }, -- Горный великан 580
			{ data = { id = 'g000uu7583', level = 2, unique = true }, weight = 5, races = { Race.Dwarf } }, -- Йамму 1015

			{ data = { id = 'g000uu0094', level = 2, unique = true }, weight = 6, races = { Race.Undead } }, -- Дракон Рока 630
			{ data = { id = 'g001uu7563', level = 2, unique = true }, weight = 2, races = { Race.Undead } }, -- Волколак 600
			{ data = { id = 'g001uu7564', level = 2, unique = true }, weight = 2, races = { Race.Undead } }, -- Хорт 600
			{ data = { id = 'g001uu7565', level = 2, unique = true }, weight = 2, races = { Race.Undead } }, -- Чумной оборотень 600
			{ data = { id = 'g000uu0174', level = 3, unique = true }, weight = 3, races = { Race.Undead } }, -- Тень 860
			{ data = { id = 'g001uu8267', level = 3, unique = true }, weight = 3, races = { Race.Undead } }, -- Эльф-призрак 860

			{ data = { id = 'g000uu0058', level = 2, unique = true }, weight = 2, races = { Race.Heretic } }, -- Демон 580
			{ data = { id = 'g000uu7577', level = 2, unique = true }, weight = 2, races = { Race.Heretic } }, -- Сатир 915
			{ data = { id = 'g000uu7572', level = 2, unique = true }, weight = 1, races = { Race.Heretic } }, -- Апатитовая гаргулья 580
			{ data = { id = 'g000uu0056', level = 2, unique = true }, weight = 1, races = { Race.Heretic } }, -- Мраморная гаргулья 580

			{ data = { id = 'g000uu8030', level = 2, unique = true }, weight = 5, races = { Race.Elf } }, -- Владыка Небес 925
			{ data = { id = 'g003uu8038', level = 2, unique = true }, weight = 5, races = { Race.Elf } }, -- Энт-целитель 700
			{ data = { id = 'g000uu8033', level = 3, unique = true }, weight = 1, races = { Race.Elf } }, -- Лесная дева 775
			{ data = { id = 'g000uu8017', level = 3, unique = true }, weight = 1, races = { Race.Elf } }, -- Кентавр-дикарь 855
			{ data = { id = 'g000uu2012', level = 3, unique = true }, weight = 1, races = { Race.Elf } }, -- Кентавр Стрелок 855
			{ data = { id = 'g000uu8227', level = 3, unique = true }, weight = 1, races = { Race.Elf } }, -- Знахарь 730
			{ data = { id = 'g000uu8021', level = 3, unique = true }, weight = 1, races = { Race.Elf } }, -- Бандит 830
		}
	}
}
--- т3
Pools.mercenaries.t3 = {
	m1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { id = 'g000uu7628', level = 3, unique = false }, weight = 1 }, -- Имперский Гвардеец 175
			{ data = { id = 'g000uu7627', level = 3, unique = false }, weight = 1 }, -- Советник Витара 175
			{ data = { id = 'g001uu7592', level = 3, unique = false }, weight = 1 }, -- Торхот 175
			{ data = { id = 'g000uu7605', level = 3, unique = false }, weight = 1 }, -- Скульптор лжи 175
			{ data = { id = 'g000uu7629', level = 3, unique = false }, weight = 1 }, -- Благородный эльф 175
		}
	},
	m2 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { id = 'g000uu5033', level = 1, unique = true }, weight = 1 }, -- Упырь 220
			{ data = { id = 'g000uu2006', level = 1, unique = true }, weight = 1 }, -- Наяда 235
			{ data = { id = 'g000uu8157', level = 1, unique = true }, weight = 1 }, -- Гоблин-громыхун 400
			{ data = { id = 'g000uu8213', level = 1, unique = true }, weight = 1 }, -- Гоблин-шаман 525
			{ data = { id = 'g000uu8048', level = 1, unique = true }, weight = 1 }, -- Старейшина Гоблинов 570
		}
	},
	m3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { id = 'g000uu7590', level = 1, unique = true }, weight = 1 }, -- Ящер-охотник 590
			{ data = { id = 'g000uu8042', level = 1, unique = true }, weight = 1 }, -- Темный Эльф Потрошитель 625
			{ data = { id = 'g000uu8041', level = 1, unique = true }, weight = 1 }, -- Темный Эльф Мясник 625
			{ data = { id = 'g000uu7619', level = 1, unique = true }, weight = 1 }, -- Слуга культа 625
			{ data = { id = 'g000uu5012', level = 1, unique = true }, weight = 1 }, -- Орк-багатур 750
			{ data = { id = 'g000uu7607', level = 1, unique = true }, weight = 1 }, -- Черный ядозуб 825
			{ data = { id = 'g000uu8043', level = 1, unique = true }, weight = 1 }, -- Жрица Безмясой 900
			{ data = { id = 'g000uu8005', level = 1, unique = true }, weight = 1 }, -- Дух волка 990
		}
	},
	m4 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { id = 'g001uu7617', level = 1, unique = true }, weight = 1 }, -- Тень культа 1070
			{ data = { id = 'g000uu6121', level = 1, unique = true }, weight = 1 }, -- Дхампир 1070
			{ data = { id = 'g000uu6106', level = 1, unique = true }, weight = 1 }, -- Принцесса гномов 1200
			{ data = { id = 'g000uu8151', level = 1, unique = true }, weight = 1 }, -- Фурия 1215
			{ data = { id = 'g001uu7560', level = 1, unique = true }, weight = 1 }, -- Каратель 1230
			{ data = { id = 'g000uu5026', level = 1, unique = true }, weight = 1 }, -- Русалка 1320
			{ data = { id = 'g000uu8275', level = 1, unique = true }, weight = 1 }, -- Медуза 1250
			{ data = { id = 'g000uu8174', level = 1, unique = true }, weight = 1 }, -- Вестник распада 1400
		}
	},
	m5 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { id = 'g002uu5026', level = 1, unique = true }, weight = 1 }, -- Элементаль Воды 1450
			{ data = { id = 'g001uu7586', level = 1, unique = true }, weight = 1 }, -- Легат 1480
			{ data = { id = 'g000uu6109', level = 1, unique = true }, weight = 1 }, -- Женщина-некромант 1500
			{ data = { id = 'g000uu8277', level = 1, unique = true }, weight = 1 }, -- Уста Богов 1520
			{ data = { id = 'g001uu7620', level = 1, unique = true }, weight = 1 }, -- Одержимый великан 1560
			{ data = { id = 'g000uu8035', level = 1, unique = true }, weight = 1 }, -- Висильда 1620
			{ data = { id = 'g000uu8218', level = 1, unique = true }, weight = 1 }, -- Волхв 1750
			{ data = { id = 'g000uu7567', level = 1, unique = true }, weight = 1 }, -- Первородная сущность 1800 (ожог)
			{ data = { id = 'g000uu7566', level = 1, unique = true }, weight = 1 }, -- Первородная сущность 1800 (мороз)
			{ data = { id = 'g000uu8237', level = 1, unique = true }, weight = 1 }, -- Первородная сущность 1800 (РБ)
			{ data = { id = 'g000uu0190', level = 1, unique = true }, weight = 1 }, -- Дух Фенрира 2000
			{ data = { id = 'g000uu5010', level = 1, unique = true }, weight = 1 }, -- Облачная Погибель 2370
		}
	},
	m6 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			--- Human
			{ data = { id = 'g000uu7595', level = 2, unique = true }, weight = 3, races = { Race.Human } }, -- Рефаим 915
			{ data = { id = 'g000uu0003', level = 3, unique = true }, weight = 3, races = { Race.Human } }, -- Имперский рыцарь 715
			{ data = { id = 'g000uu0005', level = 3, unique = true }, weight = 3, races = { Race.Human } }, -- Инквизитор 775
			{ data = { id = 'g000uu2015', level = 3, unique = true }, weight = 3, races = { Race.Human } }, -- Страж Святости 695
			{ data = { id = 'g003uu5003', level = 3, unique = true }, weight = 3, races = { Race.Human } }, -- Ревнитель 765
			{ data = { id = 'g003uu5003', level = 3, unique = true }, weight = 3, races = { Race.Human } }, -- Ардет 855
			{ data = { id = 'g000uu2030', level = 3, unique = true }, weight = 3, races = { Race.Human } }, -- Детектив 715
			--- Dwarf
			{ data = { id = 'g000uu7583', level = 2, unique = true }, weight = 3, races = { Race.Dwarf } }, -- Йамму 1015
			{ data = { id = 'g000uu0031', level = 3, unique = true }, weight = 3, races = { Race.Dwarf } }, -- Повелитель бурь 1880
			{ data = { id = 'g000uu8224', level = 3, unique = true }, weight = 3, races = { Race.Dwarf } }, -- Каменный великан 1880
			{ data = { id = 'g000uu0032', level = 3, unique = true }, weight = 3, races = { Race.Dwarf } }, -- Ледяной великан 1880
			--- Undead
			{ data = { id = 'g001uu7563', level = 2, unique = true }, weight = 3, races = { Race.Undead } }, -- Волколак 600
			{ data = { id = 'g001uu7564', level = 2, unique = true }, weight = 3, races = { Race.Undead } }, -- Хорт 600
			{ data = { id = 'g001uu7565', level = 2, unique = true }, weight = 3, races = { Race.Undead } }, -- Чумной оборотень 600
			{ data = { id = 'g000uu0088', level = 3, unique = true }, weight = 3, races = { Race.Undead } }, -- Скелет-воин 720
			{ data = { id = 'g000uu0091', level = 3, unique = true }, weight = 3, races = { Race.Undead } }, -- Лорд Тьмы 770
			{ data = { id = 'g003uu5012', level = 3, unique = true }, weight = 3, races = { Race.Undead } }, -- Орк-палач 880
			--- Heretic
			{ data = { id = 'g000uu7577', level = 3, unique = true }, weight = 3, races = { Race.Heretic } }, -- Сатир 915
			{ data = { id = 'g000uu0167', level = 3, unique = true }, weight = 3, races = { Race.Heretic } }, -- Ониксовая гаргулья 1880
			{ data = { id = 'g001uu7574', level = 3, unique = true }, weight = 3, races = { Race.Heretic } }, -- Цитриновая гаргулья 1880
			{ data = { id = 'g001uu8272', level = 3, unique = true }, weight = 3, races = { Race.Heretic } }, -- Азуритовая гаргулья 1880
			{ data = { id = 'g001uu7573', level = 3, unique = true }, weight = 3, races = { Race.Heretic } }, -- Чароитовая гаргулья 1880
			--- Elf
			{ data = { id = 'g000uu8030', level = 2, unique = true }, weight = 3, races = { Race.Elf } }, -- Владыка Небес 925
			{ data = { id = 'g003uu8038', level = 2, unique = true }, weight = 3, races = { Race.Elf } }, -- Энт-целитель 700
			{ data = { id = 'g000uu8017', level = 3, unique = true }, weight = 3, races = { Race.Elf } }, -- Кентавр-дикарь 855
			{ data = { id = 'g001uu7579', level = 3, unique = true }, weight = 3, races = { Race.Elf } }, -- Кентавр-гвардеец 905
		}
	},
	m7 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			--- Human
			{ data = { id = 'g000uu0154', level = 3, unique = true }, weight = 3, races = { Race.Human } }, -- Ассасин 805
			{ data = { id = 'g000uu7562', level = 3, unique = true }, weight = 3, races = { Race.Human } }, -- Бореалис 805
			{ data = { id = 'g000uu2009', level = 3, unique = true }, weight = 3, races = { Race.Human } }, -- Клинок в тени 805
			{ data = { id = 'g000uu0010', level = 3, unique = true }, weight = 3, races = { Race.Human } }, -- Маг 705
			{ data = { id = 'g001uu7581', level = 3, unique = true }, weight = 3, races = { Race.Human } }, -- Заклинатель 705
			{ data = { id = 'g000uu0153', level = 3, unique = true }, weight = 3, races = { Race.Human } }, -- Ученик-элементалист 705
			--- Dwarf
			{ data = { id = 'g000uu0038', level = 3, unique = true }, weight = 2, races = { Race.Dwarf } }, -- Ветеран 795
			{ data = { id = 'g000uu0041', level = 3, unique = true }, weight = 2, races = { Race.Dwarf } }, -- Горец 795
			{ data = { id = 'g000uu0162', level = 3, unique = true }, weight = 1, races = { Race.Dwarf } }, -- Защитник горна 875
			{ data = { id = 'g006uu1128', level = 3, unique = true }, weight = 2, races = { Race.Dwarf } }, -- Мастер печи 875
			{ data = { id = 'g000uu7568', level = 3, unique = true }, weight = 1, races = { Race.Dwarf } }, -- Сотрясатель 875
			{ data = { id = 'g001uu7571', level = 2, unique = true }, weight = 2, races = { Race.Dwarf } }, -- Белый волк 710
			{ data = { id = 'g004uu8005', level = 2, unique = true }, weight = 2, races = { Race.Dwarf } }, -- Гарм 710
			--- Undead
			{ data = { id = 'g000uu0082', level = 3, unique = true }, weight = 3, races = { Race.Undead } }, -- Некромант 710
			{ data = { id = 'g001uu7598', level = 3, unique = true }, weight = 3, races = { Race.Undead } }, -- Теневидец 710
			{ data = { id = 'g000uu0085', level = 3, unique = true }, weight = 3, races = { Race.Undead } }, -- Злой дух 810
			{ data = { id = 'g000uu2007', level = 3, unique = true }, weight = 3, races = { Race.Undead } }, -- Мумификатор 860
			{ data = { id = 'g000uu0095', level = 3, unique = true }, weight = 1, races = { Race.Undead } }, -- Дракон Смерти 1630
			--- Heretic
			{ data = { id = 'g000uu0054', level = 3, unique = true }, weight = 3, races = { Race.Heretic } }, -- Черный паладин 630
			{ data = { id = 'g000uu2003', level = 3, unique = true }, weight = 3, races = { Race.Heretic } }, -- Мучитель 630
			{ data = { id = 'g000uu0064', level = 3, unique = true }, weight = 3, races = { Race.Heretic } }, -- Демонолог 760
			{ data = { id = 'g000uu0171', level = 3, unique = true }, weight = 1, races = { Race.Heretic } }, -- Подражатель 1200
			{ data = { id = 'g000uu0067', level = 3, unique = true }, weight = 1, races = { Race.Heretic } }, -- Ведьма 210
			{ data = { id = 'g004uu6101', level = 2, unique = true }, weight = 1, races = { Race.Heretic } }, -- Дьяволенок 916
			--- Elf
			{ data = { id = 'g000uu2012', level = 3, unique = true }, weight = 1, races = { Race.Elf } }, -- Кентавр Стрелок 855
			{ data = { id = 'g000uu8021', level = 3, unique = true }, weight = 3, races = { Race.Elf } }, -- Бандит 830
			{ data = { id = 'g000uu8020', level = 3, unique = true }, weight = 3, races = { Race.Elf } }, -- Стингер 830
			{ data = { id = 'g000uu8020', level = 3, unique = true }, weight = 1, races = { Race.Elf } }, -- Стражник 780
			{ data = { id = 'g000uu8020', level = 3, unique = true }, weight = 1, races = { Race.Elf } }, -- Часовой 780
			{ data = { id = 'g000uu8028', level = 3, unique = true }, weight = 3, races = { Race.Elf } }, -- Тиург 730
			{ data = { id = 'g000uu8227', level = 3, unique = true }, weight = 3, races = { Race.Elf } }, -- Знахарь 730
			{ data = { id = 'g000uu8027', level = 3, unique = true }, weight = 3, races = { Race.Elf } }, -- Архонт 730
		}
	}
}
--- т5
Pools.mercenaries.t5 = {
	m1 = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ data = { id = 'g000uu7627', level = 3, unique = true }, weight = 1 }, -- Советник Витара 225(175)
			{ data = { id = 'g001uu7592', level = 3, unique = true }, weight = 1 }, -- Торхот 225(175)
			{ data = { id = 'g000uu7605', level = 3, unique = true }, weight = 1 }, -- Скульптор лжи 225(175)
		}
	},
	m2 = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ data = { id = 'g000uu7628', level = 3, unique = true }, weight = 1, amount = 2 }, -- Имперский гвардеец 875(175)
			{ data = { id = 'g000uu7629', level = 3, unique = true }, weight = 1, amount = 2 }, -- Благородный эльф 875(175)
		}
	},
	m3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { id = 'g001uu7624', level = 1, unique = true }, weight = 1 }, -- Неприкаянная 1900
			{ data = { id = 'g000uu6108', level = 1, unique = true }, weight = 1 }, -- Барон 1940
			{ data = { id = 'g000uu7589', level = 1, unique = true }, weight = 1 }, -- Осквернитель 2500
			{ data = { id = 'g001uu7596', level = 1, unique = true }, weight = 1 }, -- Сюзерен бездны 2620
			{ data = { id = 'g000uu8244', level = 1, unique = true }, weight = 1 }, -- Отступник 3250
			{ data = { id = 'g006uu1026', level = 1, unique = true }, weight = 1 }, -- Жрец Смерти 3250
		}
	},
	m4 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ data = { id = 'g000uu5014', level = 1, unique = true }, weight = 1 }, -- Хан орков 3000
			{ data = { id = 'g001uu8255', level = 1, unique = true }, weight = 1 }, -- Эльф-тень 3200
			{ data = { id = 'g000uu8278', level = 1, unique = true }, weight = 1 }, -- Божественная Длань 3400
			{ data = { id = 'g001uu7600', level = 1, unique = true }, weight = 1 }, -- Длань инквизиции 3400
			{ data = { id = 'g000uu7603', level = 1, unique = true }, weight = 1 }, -- Несущий скорбь 3800
			{ data = { id = 'g000uu8153', level = 1, unique = true }, weight = 1 }, -- Жнец 4100
			{ data = { id = 'g000uu8304', level = 1, unique = true }, weight = 1 }, -- Ангел разорения 4200
			{ data = { id = 'g000uu8231', level = 1, unique = true }, weight = 1 }, -- Катафрактарий 4700
			{ data = { id = 'g000uu8305', level = 1, unique = true }, weight = 1 }, -- Предвестница Смерти 5050
		}
	}
}

------------------------------------------------------------------------------------------------------------------------
--- Лидеры
------------------------------------------------------------------------------------------------------------------------
local workers_mods = {
	g040um0279 = 1, -- Ничто
	g000um9034 = 5, -- -10% ОД
	g201um9108 = 100, -- -1 точности
	g000um9032 = 5, -- -1 лидерство
	g201um9037 = 4, -- -1 радиус обзора
	g201um9042 = 1, -- -бонус дорог
	g000um9030 = 1, -- неподкупность
	g070um0298 = 1, -- иммунитет к магии
}
local bes_t0_mods = {
	g000um9023 = 1, -- Артефакты
	g000um9024 = 1, -- Реликвии
	g000um9025 = 1, -- Знамена
	g000um9027 = 1, -- Сферы
	g000um9029 = 1, -- Свитки
	g100um9003 = 10, -- +1 armor
	g201um9210 = 2, -- +10 move
	g201um9212 = 0, -- +1 move
	g201um9182 = 4, -- 25% bodyguard
	g201um9045 = 1, -- regen up to 25%
	g201um9130 = 1, -- +10 negotiation
	g201um9139 = 1, -- 1 source - life

	g070um0014 = 1, -- Некромант | Нежить
	g070um0217 = 1, -- Шествие орд | Рыцарь Смерти
	g070um0064 = 1, -- Боевое построение | Рыцарь на Пегасе
	--g070um0130 = 1, -- Энергетическое эхо | Архимаг
	g070um0069 = 1, -- Плечом к плечу | Королевский страж
	--g070um0172 = 1, -- Путь страданий | Советник
}
local bes_t3_mods = {
	g000um9027 = 1, -- Сферы
	g201um9106 = 4, -- +1acc
	g201um9119 = 12, -- -1ini
	g201um9214 = 4, -- +50hp
	g201um9046 = 1, -- regen up to 50%
	g201um9130 = 1, -- +10 negotiation
}
Pools.leaders = {
	workers_s1 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			-- СУЗ
			{ id = 'g000uu6008', amount = 1, weight = 1, name = 'Райз', modifiers = workers_mods },
			{ id = 'g000uu6008', amount = 1, weight = 1, name = 'Бэка', modifiers = workers_mods },
			{ id = 'g000uu6008', amount = 1, weight = 1, name = 'Гастрофетус', modifiers = workers_mods },
			-- Фумитоксал
			{ id = 'g000uu7617', amount = 1, weight = 1, name = 'Фуми', modifiers = workers_mods },
			{ id = 'g000uu7617', amount = 1, weight = 1, name = 'Токсин', modifiers = workers_mods },
			{ id = 'g000uu7617', amount = 1, weight = 1, name = 'Хрусталь', modifiers = workers_mods },
			-- ППсД
			{ id = 'g000uu5131', amount = 1, weight = 1, name = 'Магвай', modifiers = workers_mods },
			{ id = 'g000uu5131', amount = 1, weight = 1, name = 'Тезос', modifiers = workers_mods },
			{ id = 'g000uu5131', amount = 1, weight = 1, name = 'РингОф', modifiers = workers_mods },
			-- Секс Флотилия
			{ id = 'g000uu5130', amount = 1, weight = 1, name = 'Грон', modifiers = workers_mods },
			{ id = 'g000uu5130', amount = 1, weight = 1, name = 'Сыр Зерг', modifiers = workers_mods },
			{ id = 'g000uu5130', amount = 1, weight = 1, name = 'Протостар', modifiers = workers_mods },
			-- Сектанты
			{ id = 'g000uu5101', amount = 1, weight = 1, name = 'Ифрит', modifiers = workers_mods },
			{ id = 'g000uu5101', amount = 1, weight = 1, name = 'Хай', modifiers = workers_mods },
			{ id = 'g000uu5101', amount = 1, weight = 1, name = 'Амодеус', modifiers = workers_mods },
			-- Легенды операции "Ы"
			{ id = 'g000uu5101', amount = 1, weight = 1, name = 'Талион', modifiers = workers_mods },
			{ id = 'g000uu5101', amount = 1, weight = 1, name = 'Зухендер', modifiers = workers_mods },
			{ id = 'g000uu5101', amount = 1, weight = 1, name = 'ОР', modifiers = workers_mods },
			-- Ламборгини Хуракан
			{ id = 'g000uu5101', amount = 1, weight = 1, name = 'Макрометр', modifiers = workers_mods },
			{ id = 'g000uu5101', amount = 1, weight = 1, name = 'Дзаро', modifiers = workers_mods },
			{ id = 'g000uu5101', amount = 1, weight = 1, name = 'Акира', modifiers = workers_mods },
		}
	},
	bes_t0 = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = 'g000uu6004', amount = 1, weight = 1, modifiers = bes_t0_mods },
		}
	},
	bes_t3 = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = 'g000uu6004', amount = 1, weight = 1, name = 'Претендент', modifiers = bes_t3_mods },
		}
	},
}

------------------------------------------------------------------------------------------------------------------------
--- Субрасы
------------------------------------------------------------------------------------------------------------------------
Pools.subraces = {}

------------------------------------------------------------------------------------------------------------------------
--- Рудники
------------------------------------------------------------------------------------------------------------------------
Pools.mines = {
	-- Золото
	gold = {
		t0 = { items = { { id = 'gold', amount = 0, weight = 1 } }, priority = PoolPriority.UNLIMITED },
		t1 = { items = { { id = 'gold', amount = 0, weight = 1 } }, priority = PoolPriority.UNLIMITED },
		t2 = { items = { { id = 'gold', amount = 0, weight = 1 } }, priority = PoolPriority.UNLIMITED },
		t3 = { items = { { id = 'gold', amount = 0, weight = 1 } }, priority = PoolPriority.UNLIMITED },
		t4 = { items = { { id = 'gold', amount = 2, weight = 1 } }, priority = PoolPriority.UNLIMITED },
		t5 = { items = { { id = 'gold', amount = 1, weight = 1 } }, priority = PoolPriority.UNLIMITED },
	},
	-- Родная мана
	racial = {
		priority = PoolPriority.UNLIMITED,
		items = {
			{ id = 'lifeMana', amount = 1, weight = 1, races = {Race.Human} },
			{ id = 'runicMana', amount = 1, weight = 1, races = {Race.Dwarf} },
			{ id = 'deathMana', amount = 1, weight = 1, races = {Race.Undead} },
			{ id = 'infernalMana', amount = 1, weight = 1, races = {Race.Heretic} },
			{ id = 'groveMana', amount = 1, weight = 1, races = {Race.Elf} },
		}
	},
	-- т0-т2 первичная мана
	first = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'lifeMana', amount = 1, weight = 1, races = {Race.Dwarf, Race.Elf} },
			{ id = 'runicMana', amount = 1, weight = 1, races = {Race.Human} },
			{ id = 'deathMana', amount = 1, weight = 1, races = {Race.Heretic} },
			{ id = 'infernalMana', amount = 1, weight = 1, races = {Race.Undead, Race.Elf} },
			{ id = 'groveMana', amount = 1, weight = 1, races = {Race.Human, Race.Dwarf, Race.Undead, Race.Heretic} },
		}
	},
	-- т0-т2 вторичная мана
	second = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'lifeMana', amount = 1, weight = 1, races = {Race.Undead, Race.Heretic} },
			{ id = 'runicMana', amount = 1, weight = 1, races = {Race.Undead, Race.Heretic, Race.Elf} },
			{ id = 'deathMana', amount = 1, weight = 1, races = {Race.Human, Race.Dwarf, Race.Elf} },
			{ id = 'infernalMana', amount = 1, weight = 1, races = {Race.Human, Race.Dwarf} },
			{ id = 'groveMana', amount = 0, weight = 0, races = {} },
		}
	},
	-- т3 мана + золото
	t3 = {
		priority = PoolPriority.AS_POSSIBLE,
		items = {
			{ id = 'gold', amount = 1, weight = 1},
			{ id = 'lifeMana', amount = 1, weight = 9999},
			{ id = 'runicMana', amount = 1, weight = 9999},
			{ id = 'deathMana', amount = 1, weight = 9999},
			{ id = 'infernalMana', amount = 1, weight = 9999},
			{ id = 'groveMana', amount = 1, weight = 9999},
		}
	}
}

------------------------------------------------------------------------------------------------------------------------
--- Функции системы распределения данных
------------------------------------------------------------------------------------------------------------------------
-- Функции обработки для разных типов данных
local RequestHandlers = {
	[RequestType.ITEMS] = function(object, items_data_entries)
		-- Проверяем, есть ли у объекта поле goods (для торговца)
		if object.goods then
			-- Для торговца: добавляем предметы в goods.items
			if not object.goods.items then object.goods.items = {} end

			for _, entry in ipairs(items_data_entries) do
				table.insert(object.goods.items, entry)
			end
		else
			-- Для всех остальных объектов: добавляем в loot.items
			if not object.loot then object.loot = {} end
			if not object.loot.items then object.loot.items = {} end

			for _, entry in ipairs(items_data_entries) do
				table.insert(object.loot.items, entry)
			end
		end
	end,

	[RequestType.SPELLS] = function(object, spell_entries)
		-- Проверяем и создаем таблицу заклинаний, если нужно
		if not object.spells then object.spells = {} end

		for _, entry in ipairs(spell_entries) do
			-- entry.id теперь таблица заклинания, берем из нее поле id
			local spell_id = entry.id.id

			-- Добавляем ID заклинания в список
			table.insert(object.spells, spell_id)
		end
	end,

	[RequestType.TOWN_DATA] = function(town, data_entries)
		if #data_entries > 0 then
			local data = data_entries[1].data
			town.name = data.name
			if data.description then
				town.description = data.description
			end
		end
	end,

	[RequestType.RUIN_DATA] = function(ruin, data_entries)
		if #data_entries > 0 then
			local data = data_entries[1].data
			ruin.name = data.name
			if data.description then
				ruin.description = data.description
			end
		end
	end,

	[RequestType.MERCHANT_DATA] = function(merchant, data_entries)
		if #data_entries > 0 then
			local data = data_entries[1].data
			merchant.name = data.name
			merchant.description = data.description or ""
		end
	end,

	[RequestType.MAGE_DATA] = function(mage, data_entries)
		if #data_entries > 0 then
			local data = data_entries[1].data
			mage.name = data.name
			mage.description = data.description or ""
		end
	end,

	[RequestType.TRAINER_DATA] = function(trainer, data_entries)
		if #data_entries > 0 then
			local data = data_entries[1].data
			trainer.name = data.name
			trainer.description = data.description or ""
		end
	end,

	[RequestType.MARKET_DATA] = function(market, data_entries)
		if #data_entries > 0 then
			local data = data_entries[1].data
			market.name = data.name
			market.description = data.description or ""
		end
	end,

	[RequestType.MERCENARY_DATA] = function(mercenary, data_entries)
		if #data_entries > 0 then
			local data = data_entries[1].data

			-- Устанавливаем имя и описание
			if data.name then
				mercenary.name = data.name
			end
			if data.description then
				mercenary.description = data.description
			end

			-- Добавляем юниты, если они указаны в данных
			if data.units then
				if not mercenary.units then mercenary.units = {} end

				-- Проверяем, массив ли это или одиночный юнит
				if data.units.id then
					-- Одиночный юнит
					table.insert(mercenary.units, {
						id = data.units.id,
						level = data.units.level,
						unique = data.units.unique or false
					})
				elseif type(data.units) == "table" then
					-- Массив юнитов
					for _, unit_data in ipairs(data.units) do
						table.insert(mercenary.units, {
							id = unit_data.id,
							level = unit_data.level,
							unique = unit_data.unique or false
						})
					end
				end
			end
		end
	end,

	[RequestType.MERCENARY_UNITS] = function(mercenary, unit_entries)
		-- Если у mercenary еще нет units, создаем пустую таблицу
		if not mercenary.units then mercenary.units = {} end

		for _, entry in ipairs(unit_entries) do
			local unit_data = entry.data

			-- Создаем запись юнита в формате, который ожидается в шаблоне
			local unit_entry = {
				id = unit_data.id,
				unique = unit_data.unique or false
			}

			-- Если указан уровень, добавляем его
			if unit_data.level then
				unit_entry.level = unit_data.level
			end

			table.insert(mercenary.units, unit_entry)
		end
	end,

	[RequestType.LEADERS] = function(stack, leader_entries)
		-- Инициализируем список лидеров, если его нет
		if not stack.leaderIds then
			stack.leaderIds = {}
		end

		-- Инициализируем список модификаторов, если его нет
		if not stack.leaderModifiers then
			stack.leaderModifiers = {}
		end

		-- Добавляем лидеров из распределенных записей
		for _, entry in ipairs(leader_entries) do
			table.insert(stack.leaderIds, entry.id)

			if entry.name then
				stack.name = entry.name
			end

			-- Если у лидера есть модификаторы, добавляем их в leaderModifiers
			if entry.modifiers then
				-- entry.modifiers - это таблица {modifier_id = количество, ...}
				for modifier_id, count in pairs(entry.modifiers) do
					-- Добавляем модификатор указанное количество раз
					for i = 1, count do
						table.insert(stack.leaderModifiers, modifier_id)
					end
				end
			end
		end
	end,

	[RequestType.SUBRACES] = function(stack, subrace_entries)
		-- Инициализируем список подрас, если его нет
		if not stack.subraceTypes then
			stack.subraceTypes = {}
		end

		-- Добавляем подрасы из распределенных записей
		for _, entry in ipairs(subrace_entries) do
			if entry.id then
				if type(entry.id) == "table" then
					-- Если это список ID, добавляем все
					for _, subrace_id in ipairs(entry.id) do
						-- Проверяем, что такая подраса еще не добавлена
						local exists = false
						for _, existing in ipairs(stack.subraceTypes) do
							if existing == subrace_id then
								exists = true
								break
							end
						end
						if not exists then
							table.insert(stack.subraceTypes, subrace_id)
						end
					end
				else
					-- Если это одиночный ID, добавляем его
					local exists = false
					for _, existing in ipairs(stack.subraceTypes) do
						if existing == entry.id then
							exists = true
							break
						end
					end
					if not exists then
						table.insert(stack.subraceTypes, entry.id)
					end
				end
			end
		end
	end,

	[RequestType.MINES] = function(mines, mine_entries)
		-- Обрабатываем каждый распределённый рудник
		for _, entry in ipairs(mine_entries) do
			local resource_id = entry.id
			local amount = entry.min  -- entry.min и entry.max одинаковы для рудников

			mines[resource_id] = (mines[resource_id] or 0) + amount
		end
	end,
}

-- Вспомогательная функция для проверки доступности элемента по расе
local function isElementAvailableForRace(element, race)
	-- Если раса не передана, элементы без races доступны, элементы с races - недоступны
	if not race then
		return not element.races or #element.races == 0
	end

	-- Если у элемента нет списка рас или список пустой - доступен всем
	if not element.races or #element.races == 0 then
		return true
	end

	-- Проверяем, есть ли указанная раса в списке
	for _, r in ipairs(element.races) do
		if r == race then
			return true
		end
	end

	return false
end

-- Инициализация
function DistributionSystem:init()
	if self.initialized then return end

	self.requests = {}
	self.pool_instances = {}
	self.pool_registry = {}
	self.initialized = true
end

-- Генерация уникального ключа для пула
local function getPoolKey(pool_path)
	return table.concat(pool_path, ".")
end

-- Получение пути к пулу в структуре Pools
local function findPoolPath(pool_object, current, path)
	if pool_object == current then
		return path
	end

	if type(current) == "table" then
		for key, value in pairs(current) do
			if type(value) == "table" then
				-- Создаем новую таблицу для нового пути
				local new_path = {}
				for i = 1, #path do
					new_path[i] = path[i]
				end
				new_path[#new_path + 1] = key
				local result = findPoolPath(pool_object, value, new_path)
				if result then return result end
			end
		end
	end

	return nil
end

-- Функция для фильтрации заклинаний с учетом параметра ban
local function filterSpellsByBan(pool_items, race)
	local filtered_items = {}

	for _, item in ipairs(pool_items) do
		-- Проверяем доступность для расы (только по полю races в элементе пула)
		local is_available_for_race = true
		if race then
			if item.races and #item.races > 0 then
				-- Проверяем, есть ли указанная раса в списке races
				is_available_for_race = false
				for _, r in ipairs(item.races) do
					if r == race then
						is_available_for_race = true
						break
					end
				end
			end
			-- Если races не указано, элемент доступен всем расам
		else
			-- Если race не передана, то элементы с races недоступны
			if item.races and #item.races > 0 then
				is_available_for_race = false
			end
		end

		-- Если доступен для расы и не запрещен
		if is_available_for_race then
			local spell_data = item.id
			if type(spell_data) == "table" and spell_data.id and not spell_data.ban then
				table.insert(filtered_items, {
					id = spell_data,
					amount = item.amount or 1,
					weight = item.weight or 1.0,
					races = item.races  -- Сохраняем races из элемента пула
				})
			end
		end
	end

	return filtered_items
end

-- Получение экземпляра пула
function DistributionSystem:getPoolInstance(pool_object, race)
	if not pool_object then return nil end
	if not pool_object.items then return nil end

	-- Находим путь к пулу
	local pool_path = findPoolPath(pool_object, Pools, {})
	if not pool_path then
		pool_path = {"temp", tostring(pool_object)}
	end

	-- Создаем уникальный ключ для комбинации пул+раса
	local pool_key = getPoolKey(pool_path)
	if race then
		pool_key = pool_key .. "_race_" .. tostring(race)
	else
		pool_key = pool_key .. "_race_nil"
	end

	-- Если пул уже создан, возвращаем его
	if self.pool_instances[pool_key] then
		return self.pool_instances[pool_key]
	end

	-- Создаем новый экземпляр
	local instance = {
		items = {},
		race = race,
		key = pool_key,
		priority = pool_object.priority or PoolPriority.AS_POSSIBLE,
		source_pool = pool_object,
		distributed_count = 0,
		original_total = 0,
		is_data_pool = pool_object.items[1] and pool_object.items[1].data ~= nil
	}

	-- Заполняем элементы, фильтруя по расе если указана
	for _, element_data in ipairs(pool_object.items) do
		-- Проверяем доступность элемента для указанной расы
		if isElementAvailableForRace(element_data, race) then
			if instance.is_data_pool then
				-- Для пулов данных
				local amount = element_data.amount or 1
				table.insert(instance.items, {
					data = element_data.data,
					amount = amount,
					available = amount,
					weight = element_data.weight or 1.0,
					modifiers = element_data.modifiers,
					races = element_data.races,
					group_amount = element_data.group_amount or 1,
					name = element_data.name,
					type = element_data.type,
				})
				instance.original_total = instance.original_total + amount
			else
				-- Для обычных пулов
				local amount = element_data.amount or 1
				table.insert(instance.items, {
					id = element_data.id,
					amount = amount,
					available = amount,
					weight = element_data.weight or 1.0,
					modifiers = element_data.modifiers,
					group_amount = element_data.group_amount or 1,
					races = element_data.races,
					original_data = element_data,
					name = element_data.name,
					type = element_data.type,
				})
				instance.original_total = instance.original_total + amount
			end
		end
	end

	self.pool_instances[pool_key] = instance
	self.pool_registry[pool_key] = pool_object
	return instance
end

-- Распределить предметы из пула
function DistributionSystem:distributeFromPool(pool_instance, requested_count)
	if not pool_instance then return {} end

	-- Для UNLIMITED пулов используем отдельную логику
	if pool_instance.priority == PoolPriority.UNLIMITED then
		return self:distributeFromUnlimitedPool(pool_instance, requested_count)
	end

	local result = {}
	local collected = {}
	local selections_made = 0

	-- Определяем максимальное количество выборов
	local max_selections = requested_count

	if pool_instance.priority == PoolPriority.AS_POSSIBLE then
		local total_available = 0
		for _, item in ipairs(pool_instance.items) do
			if item.amount and item.amount > 0 then
				total_available = total_available + item.amount
			end
		end
		max_selections = math.min(requested_count, total_available)
	elseif pool_instance.priority == PoolPriority.ALL then
		local total_available = 0
		for _, item in ipairs(pool_instance.items) do
			if item.amount and item.amount > 0 then
				total_available = total_available + item.amount
			end
		end
		max_selections = math.min(requested_count, total_available)
	end

	if max_selections <= 0 then return {} end

	while selections_made < max_selections do
		local total_weight = 0
		local available_items = {}

		-- Собираем доступные предметы (amount > 0)
		for _, item in ipairs(pool_instance.items) do
			if item.amount and item.amount > 0 then
				total_weight = total_weight + (item.weight or 1)
				table.insert(available_items, item)
			end
		end

		if total_weight <= 0 then break end

		-- Выбираем предмет с учетом веса
		local random_value = math.random() * total_weight
		local accumulated = 0
		local selected_item = nil

		for _, item in ipairs(available_items) do
			accumulated = accumulated + (item.weight or 1)
			if random_value <= accumulated then
				selected_item = item
				break
			end
		end

		if not selected_item then break end

		-- Определяем сколько предметов выдать
		local group_amount = selected_item.group_amount or 1
		local to_issue = group_amount

		-- Записываем выданные предметы
		if pool_instance.is_data_pool then
			if not collected[selected_item.data] then
				collected[selected_item.data] = { data = selected_item.data, count = 0 }
			end
			collected[selected_item.data].count = collected[selected_item.data].count + to_issue
		else
			if not collected[selected_item] then
				collected[selected_item] = 0
			end
			collected[selected_item] = collected[selected_item] + to_issue
		end

		-- Уменьшаем amount на 1 (один выбор)
		selected_item.amount = selected_item.amount - 1
		pool_instance.distributed_count = pool_instance.distributed_count + 1
		selections_made = selections_made + 1
	end

	-- Форматируем результат
	if pool_instance.is_data_pool then
		for _, data_info in pairs(collected) do
			if type(data_info) == "table" and data_info.data then
				table.insert(result, {
					data = data_info.data,
					min = data_info.count,
					max = data_info.count
				})
			end
		end
	else
		for item, amount in pairs(collected) do
			local entry = {
				id = item.id,
				min = amount,
				max = amount
			}
			if item.modifiers then
				entry.modifiers = item.modifiers
			end
			if item.name then
				entry.name = item.name
			end
			table.insert(result, entry)
		end
	end

	return result
end

-- Распределить предметы из UNLIMITED пула
function DistributionSystem:distributeFromUnlimitedPool(pool_instance, requested_count)
	if not pool_instance then return {} end

	local result = {}
	local collected = {}
	local selections_made = 0

	-- Создаём временную таблицу с лимитами (remaining) для этого запроса
	local temp_items = {}
	for _, item in ipairs(pool_instance.items) do
		if item.weight and item.weight > 0 then
			local initial_amount = item.amount or 1
			if initial_amount > 0 then
				table.insert(temp_items, {
					id = item.id,
					data = item.data,
					weight = item.weight,
					group_amount = item.group_amount or 1,
					modifiers = item.modifiers,
					remaining = initial_amount   -- сколько ещё выборов этого типа допустимо
				})
			end
		end
	end

	if #temp_items == 0 then return {} end
	local is_data_pool = pool_instance.is_data_pool

	while selections_made < requested_count do
		local total_weight = 0
		for _, item in ipairs(temp_items) do
			if item.remaining > 0 then
				total_weight = total_weight + item.weight
			end
		end
		if total_weight <= 0 then break end

		local random_value = math.random() * total_weight
		local accumulated = 0
		local selected_item = nil

		for _, item in ipairs(temp_items) do
			if item.remaining > 0 then
				accumulated = accumulated + item.weight
				if random_value <= accumulated then
					selected_item = item
					break
				end
			end
		end

		if not selected_item then break end

		local to_issue = selected_item.group_amount

		if is_data_pool then
			if not collected[selected_item.data] then
				collected[selected_item.data] = { data = selected_item.data, count = 0 }
			end
			collected[selected_item.data].count = collected[selected_item.data].count + to_issue
		else
			if not collected[selected_item] then
				collected[selected_item] = 0
			end
			collected[selected_item] = collected[selected_item] + to_issue
		end

		selected_item.remaining = selected_item.remaining - 1
		selections_made = selections_made + 1
	end

	-- Формирование результата
	if is_data_pool then
		for _, data_info in pairs(collected) do
			table.insert(result, {
				data = data_info.data,
				min = data_info.count,
				max = data_info.count
			})
		end
	else
		for item, amount in pairs(collected) do
			local entry = {
				id = item.id,
				min = amount,
				max = amount
			}
			if item.modifiers then entry.modifiers = item.modifiers end
			table.insert(result, entry)
		end
	end

	return result
end

-- Обновляем функцию получения доступного количества с учетом расы
function DistributionSystem:getAvailableCount(pool_instance)
	if not pool_instance then return 0 end

	if pool_instance.priority == PoolPriority.UNLIMITED then
		-- Для UNLIMITED пулов максимальное количество выборов за запрос
		local total = 0
		for _, item in ipairs(pool_instance.items) do
			total = total + (item.amount or 0)
		end
		return total
	end

	-- Для обычных пулов: сумма amount (количество выборов)
	local total_selections = 0
	for _, item in ipairs(pool_instance.items) do
		if item.amount and item.amount > 0 then
			total_selections = total_selections + item.amount
		end
	end
	return total_selections
end

-- Обновленная функция distributeFromPool с исправленной логикой подсчета доступных выборов
function DistributionSystem:distributeFromPool(pool_instance, requested_count)
	if not pool_instance then return {} end

	if pool_instance.priority == PoolPriority.UNLIMITED then
		return self:distributeFromUnlimitedPool(pool_instance, requested_count)
	end

	local result = {}
	local collected = {}
	local selections_made = 0

	-- Максимальное количество выборов для AS_POSSIBLE/ALL
	local max_selections = requested_count
	if pool_instance.priority == PoolPriority.AS_POSSIBLE then
		local total_available = 0
		for _, item in ipairs(pool_instance.items) do
			total_available = total_available + (item.amount or 0)
		end
		max_selections = math.min(requested_count, total_available)
	elseif pool_instance.priority == PoolPriority.ALL then
		local total_available = 0
		for _, item in ipairs(pool_instance.items) do
			total_available = total_available + (item.amount or 0)
		end
		max_selections = math.min(requested_count, total_available)
	end

	if max_selections <= 0 then return {} end

	while selections_made < max_selections do
		local total_weight = 0
		local available_items = {}

		for _, item in ipairs(pool_instance.items) do
			if item.amount and item.amount > 0 then
				total_weight = total_weight + (item.weight or 1)
				table.insert(available_items, item)
			end
		end

		if total_weight <= 0 then break end

		local random_value = math.random() * total_weight
		local accumulated = 0
		local selected_item = nil

		for _, item in ipairs(available_items) do
			accumulated = accumulated + (item.weight or 1)
			if random_value <= accumulated then
				selected_item = item
				break
			end
		end

		if not selected_item then break end

		local to_issue = selected_item.group_amount or 1

		if pool_instance.is_data_pool then
			if not collected[selected_item.data] then
				collected[selected_item.data] = { data = selected_item.data, count = 0 }
			end
			collected[selected_item.data].count = collected[selected_item.data].count + to_issue
		else
			if not collected[selected_item] then
				collected[selected_item] = 0
			end
			collected[selected_item] = collected[selected_item] + to_issue
		end

		selected_item.amount = selected_item.amount - 1
		pool_instance.distributed_count = pool_instance.distributed_count + 1
		selections_made = selections_made + 1
	end

	-- Формирование результата (как было)
	if pool_instance.is_data_pool then
		for _, data_info in pairs(collected) do
			table.insert(result, {
				data = data_info.data,
				min = data_info.count,
				max = data_info.count
			})
		end
	else
		for item, amount in pairs(collected) do
			local entry = {
				id = item.id,
				min = amount,
				max = amount
			}
			if item.modifiers then entry.modifiers = item.modifiers end
			if item.name then entry.name = item.name end
			table.insert(result, entry)
		end
	end

	return result
end

-- Распределение остатков для пулов с приоритетом ALL
function DistributionSystem:distributeRemaining()
	for pool_key, instance in pairs(self.pool_instances) do
		if instance.priority == PoolPriority.ALL then
			local remaining_selections = 0
			for _, item in ipairs(instance.items) do
				remaining_selections = remaining_selections + (item.amount or 0)
			end

			if remaining_selections > 0 then
				local recipients = {}
				local recipient_types = {}

				for _, req in ipairs(self.requests) do
					if req.pool_instance == instance then
						if not recipients[req.object] then
							recipients[req.object] = true
							recipient_types[req.object] = req.type
						end
					end
				end

				local recipient_list = {}
				for recipient, _ in pairs(recipients) do
					table.insert(recipient_list, recipient)
				end

				if #recipient_list > 0 then
					local per_recipient = math.floor(remaining_selections / #recipient_list)
					local extra = remaining_selections % #recipient_list

					for i, recipient in ipairs(recipient_list) do
						local to_distribute = per_recipient
						if i <= extra then to_distribute = to_distribute + 1 end

						if to_distribute > 0 then
							local items = self:distributeFromPool(instance, to_distribute)
							if #items > 0 then
								RequestHandlers[recipient_types[recipient]](recipient, items)
							end
						end
					end
				end
			end
		end
	end
end

-- Функция запроса предметов
function DistributionSystem:requestItems(object, pool_object, count, race, isRuin)
	local pool_instance = self:getPoolInstance(pool_object, race)
	if not pool_instance then return end

	-- Проверяем, есть ли доступные предметы для этой расы
	if self:getAvailableCount(pool_instance) == 0 then
		return
	end

	if pool_instance.priority == PoolPriority.UNLIMITED then
		-- Для UNLIMITED пулов сразу выдаем предметы
		local distributed_items = self:distributeFromPool(pool_instance, count)
		if #distributed_items > 0 then
			RequestHandlers[RequestType.ITEMS](object, distributed_items)
		end
	else
		-- Для обычных пулов сохраняем запрос для последующего распределения
		table.insert(self.requests, {
			object = object,
			pool_instance = pool_instance,
			type = RequestType.ITEMS,
			count = count,
			race = race,
			isRuin = isRuin or false
		})
	end
end

-- Расширенный запрос предметов с опциональной фильтрацией по типам и уникальностью
-- @param object - объект, получающий предметы
-- @param pool_object - пул предметов
-- @param count - сколько предметов запросить
-- @param options - таблица с полями:
--   types: массив строк (например, {"weapon", "armor"}) - если не указан, фильтрации нет
--   unique: boolean - если true, в ответе не будет дубликатов по id
--   race: string - раса (опционально)
function DistributionSystem:requestItemsAdvanced(object, pool_object, count, options)
	options = options or {}
	local allowed_types = options.types
	local unique = options.unique
	local race = options.race

	if not allowed_types or type(allowed_types) ~= "table" or #allowed_types == 0 then
		self:requestItems(object, pool_object, count, race)
		return
	end

	local types_map = {}
	for _, t in ipairs(allowed_types) do
		types_map[t] = true
	end

	local pool_instance = self:getPoolInstance(pool_object, race)
	if not pool_instance then return end

	local filtered_items = {}
	for _, item in ipairs(pool_instance.items) do
		if item.type and types_map[item.type] and item.available > 0 then
			table.insert(filtered_items, item)
		end
	end

	if #filtered_items == 0 then return end

	local temp_pool = {
		priority = pool_instance.priority,
		items = filtered_items
	}
	local temp_instance = self:getPoolInstance(temp_pool, race)
	if not temp_instance then return end

	if temp_instance.priority == PoolPriority.UNLIMITED then
		local distributed = self:distributeFromPool(temp_instance, count)
		if #distributed > 0 then
			if unique then
				local seen = {}
				local unique_items = {}
				for _, entry in ipairs(distributed) do
					if not seen[entry.id] then
						seen[entry.id] = true
						table.insert(unique_items, entry)
					end
					-- Для UNLIMITED пулов возвращать дубликаты не нужно,
					-- так как они не уменьшают глобальный пул.
				end
				if #unique_items > count then
					local trimmed = {}
					for i = 1, count do
						trimmed[i] = unique_items[i]
					end
					unique_items = trimmed
				end
				distributed = unique_items
			end
			RequestHandlers[RequestType.ITEMS](object, distributed)
		end
	else
		table.insert(self.requests, {
			object = object,
			pool_instance = temp_instance,
			type = RequestType.ITEMS,
			count = count,
			race = race,
			unique = unique,
		})
	end
end

-- Функция запроса заклинаний
function DistributionSystem:requestSpells(object, pool_object, count, race)
	-- Фильтруем заклинания с учетом параметра ban и расы
	local filtered_items = filterSpellsByBan(pool_object.items, race)

	-- Если после фильтрации не осталось доступных заклинаний
	if #filtered_items == 0 then
		return
	end

	-- Создаем временный пул с отфильтрованными заклинаниями
	local temp_pool = {
		priority = pool_object.priority or PoolPriority.AS_POSSIBLE,
		items = filtered_items
	}

	-- Получаем экземпляр этого пула (передаем race для создания уникального ключа)
	local pool_instance = self:getPoolInstance(temp_pool, race)
	if not pool_instance then return end

	-- Проверяем доступность через новую getAvailableCount
	if self:getAvailableCount(pool_instance) == 0 then
		return
	end

	if pool_instance.priority == PoolPriority.UNLIMITED then
		-- Для UNLIMITED пулов сразу выдаем заклинания
		local distributed_items = self:distributeFromPool(pool_instance, count)
		if #distributed_items > 0 then
			RequestHandlers[RequestType.SPELLS](object, distributed_items)
		end
	else
		-- Для обычных пулов сохраняем запрос для последующего распределения
		table.insert(self.requests, {
			object = object,
			pool_instance = pool_instance,
			type = RequestType.SPELLS,
			count = count,
			race = race,
		})
	end
end

-- Функция запроса лидеров
function DistributionSystem:requestLeaders(stack, pool_object, count, race)
	local pool_instance = self:getPoolInstance(pool_object, race)
	if not pool_instance then return end

	-- Проверяем доступность через новую getAvailableCount
	if self:getAvailableCount(pool_instance) == 0 then
		return
	end

	if pool_instance.priority == PoolPriority.UNLIMITED then
		-- Для UNLIMITED пулов сразу выдаём лидеров
		local distributed_items = self:distributeFromPool(pool_instance, count)
		if #distributed_items > 0 then
			RequestHandlers[RequestType.LEADERS](stack, distributed_items)
		end
	else
		-- Для обычных пулов сохраняем запрос для последующего распределения
		table.insert(self.requests, {
			object = stack,
			pool_instance = pool_instance,
			type = RequestType.LEADERS,
			count = count,
			race = race
		})
	end
end

-- Функции запроса данных для разных типов объектов
-- Город
function DistributionSystem:requestTownData(town, pool_object)
	local pool_instance = self:getPoolInstance(pool_object, nil)
	if not pool_instance then return end

	-- Проверяем доступность через новую getAvailableCount
	if self:getAvailableCount(pool_instance) == 0 then
		return
	end

	local distributed_items = self:distributeFromPool(pool_instance, 1)
	if #distributed_items > 0 then
		RequestHandlers[RequestType.TOWN_DATA](town, distributed_items)
	end
end

-- Руины
function DistributionSystem:requestRuinData(ruin, pool_object)
	local pool_instance = self:getPoolInstance(pool_object, nil)
	if not pool_instance then return end

	local distributed_items = self:distributeFromPool(pool_instance, 1)
	if #distributed_items > 0 then
		RequestHandlers[RequestType.RUIN_DATA](ruin, distributed_items)
	end
end

-- Лавка торговца
function DistributionSystem:requestMerchantData(merchant, pool_object)
	local pool_instance = self:getPoolInstance(pool_object, nil)
	if not pool_instance then return end

	-- Проверяем доступность через новую getAvailableCount
	if self:getAvailableCount(pool_instance) == 0 then
		return
	end

	local distributed_items = self:distributeFromPool(pool_instance, 1)
	if #distributed_items > 0 then
		RequestHandlers[RequestType.MERCHANT_DATA](merchant, distributed_items)
	end
end

-- Башня мага
function DistributionSystem:requestMageData(mage, pool_object)
	local pool_instance = self:getPoolInstance(pool_object, nil)
	if not pool_instance then return end

	-- Проверяем доступность через новую getAvailableCount
	if self:getAvailableCount(pool_instance) == 0 then
		return
	end

	local distributed_items = self:distributeFromPool(pool_instance, 1)
	if #distributed_items > 0 then
		RequestHandlers[RequestType.MAGE_DATA](mage, distributed_items)
	end
end

-- Тренер
function DistributionSystem:requestTrainerData(trainer, pool_object)
	local pool_instance = self:getPoolInstance(pool_object, nil)
	if not pool_instance then return end

	-- Проверяем доступность через новую getAvailableCount
	if self:getAvailableCount(pool_instance) == 0 then
		return
	end

	local distributed_items = self:distributeFromPool(pool_instance, 1)
	if #distributed_items > 0 then
		RequestHandlers[RequestType.TRAINER_DATA](trainer, distributed_items)
	end
end

-- Рынок ресурсов
function DistributionSystem:requestMarketData(market, pool_object)
	local pool_instance = self:getPoolInstance(pool_object, nil)
	if not pool_instance then return end

	-- Проверяем доступность через новую getAvailableCount
	if self:getAvailableCount(pool_instance) == 0 then
		return
	end

	local distributed_items = self:distributeFromPool(pool_instance, 1)
	if #distributed_items > 0 then
		RequestHandlers[RequestType.MARKET_DATA](market, distributed_items)
	end
end

-- Лагерь наемников
function DistributionSystem:requestMercenaryData(mercenary, pool_object)
	local pool_instance = self:getPoolInstance(pool_object, nil)
	if not pool_instance then return end

	-- Проверяем доступность через новую getAvailableCount
	if self:getAvailableCount(pool_instance) == 0 then
		return
	end

	local distributed_items = self:distributeFromPool(pool_instance, 1)
	if #distributed_items > 0 then
		RequestHandlers[RequestType.MERCENARY_DATA](mercenary, distributed_items)
	end
end

-- Функция запроса юнитов наемников
function DistributionSystem:requestMercenaryUnits(mercenary, pool_object, count, race)
	local pool_instance = self:getPoolInstance(pool_object, race)
	if not pool_instance then return end

	-- Проверяем доступность через новую getAvailableCount
	if self:getAvailableCount(pool_instance) == 0 then
		return
	end

	if pool_instance.priority == PoolPriority.UNLIMITED then
		-- Для UNLIMITED пулов используем distributeFromUnlimitedPool
		local distributed_items = self:distributeFromUnlimitedPool(pool_instance, count)
		if #distributed_items > 0 then
			RequestHandlers[RequestType.MERCENARY_UNITS](mercenary, distributed_items)
		end
	else
		-- Для обычных пулов сохраняем запрос для последующего распределения
		table.insert(self.requests, {
			object = mercenary,
			pool_instance = pool_instance,
			type = RequestType.MERCENARY_UNITS,
			count = count,
			race = race
		})
	end
end

-- Функция запроса подрас
function DistributionSystem:requestSubraces(stack, pool_object, count, race)
	local pool_instance = self:getPoolInstance(pool_object, race)
	if not pool_instance then return end

	-- Проверяем доступность через новую getAvailableCount
	if self:getAvailableCount(pool_instance) == 0 then
		return
	end

	if pool_instance.priority == PoolPriority.UNLIMITED then
		-- Для UNLIMITED пулов сразу выдаём подрасы
		local distributed_items = self:distributeFromPool(pool_instance, count)
		if #distributed_items > 0 then
			RequestHandlers[RequestType.SUBRACES](stack, distributed_items)
		end
	else
		-- Для обычных пулов сохраняем запрос для последующего распределения
		table.insert(self.requests, {
			object = stack,
			pool_instance = pool_instance,
			type = RequestType.SUBRACES,
			count = count,
			race = race
		})
	end
end

-- Функция запроса рудников
function DistributionSystem:requestMines(zone, pool_object, count, race)
	local pool_instance = self:getPoolInstance(pool_object, race)
	if not pool_instance then return end

	-- Проверяем доступность через новую getAvailableCount
	if self:getAvailableCount(pool_instance) == 0 then
		return
	end

	if pool_instance.priority == PoolPriority.UNLIMITED then
		-- Для UNLIMITED пулов сразу выдаём рудники
		local distributed_items = self:distributeFromPool(pool_instance, count)
		if #distributed_items > 0 then
			RequestHandlers[RequestType.MINES](zone, distributed_items)
		end
	else
		-- Для обычных пулов сохраняем запрос для последующего распределения
		table.insert(self.requests, {
			object = zone,
			pool_instance = pool_instance,
			type = RequestType.MINES,
			count = count,
			race = race
		})
	end
end

-- Возвращает один выбор предмета обратно в пул (увеличивает amount на 1)
function DistributionSystem:returnSingleItem(pool_instance, entry)
	for _, item in ipairs(pool_instance.items) do
		if item.id == entry.id then
			item.amount = item.amount + 1
			if item.available then item.available = item.amount end
			break
		end
	end
end

-- Выполнение распределения
function DistributionSystem:distribute()
	shake(self.requests)
	for _, req in ipairs(self.requests) do
		local distributed_items = self:distributeFromPool(req.pool_instance, req.count, req.race)
		if #distributed_items > 0 then
			if req.unique then
				local seen = {}
				local unique_items = {}
				for _, entry in ipairs(distributed_items) do
					if not seen[entry.id] then
						seen[entry.id] = true
						table.insert(unique_items, entry)
					else
						-- дубликат — возвращаем обратно в пул
						self:returnSingleItem(req.pool_instance, entry)
					end
				end
				-- Если уникальных больше, чем запрошено, возвращаем лишние
				if #unique_items > req.count then
					shake(unique_items) -- случайный порядок
					for i = req.count + 1, #unique_items do
						self:returnSingleItem(req.pool_instance, unique_items[i])
					end
					-- оставляем первые req.count
					local trimmed = {}
					for i = 1, req.count do
						trimmed[i] = unique_items[i]
					end
					unique_items = trimmed
				end
				distributed_items = unique_items
			end
			RequestHandlers[req.type](req.object, distributed_items)
		end
	end
	self:distributeRemaining()
end

-- Функция запроса лидеров
function DistributionSystem:requestLeaders(stack, pool_object, count, race)
	local pool_instance = self:getPoolInstance(pool_object, race)
	if not pool_instance then return end

	if pool_instance.priority == PoolPriority.UNLIMITED then
		-- Для UNLIMITED пулов сразу выдаём лидеров
		local distributed_items = self:distributeFromPool(pool_instance, count)
		if #distributed_items > 0 then
			RequestHandlers[RequestType.LEADERS](stack, distributed_items)
		end
	else
		-- Для обычных пулов сохраняем запрос для последующего распределения
		table.insert(self.requests, {
			object = stack,
			pool_instance = pool_instance,
			type = RequestType.LEADERS,
			count = count,
			race = race
		})
	end
end

-- Глобальный экземпляр
local Distributor = DistributionSystem

------------------------------------------------------------------------------------------------------------------------
--- Бан-листы
------------------------------------------------------------------------------------------------------------------------
local forbidden = {}
forbidden.ruins = {
	'g000uu5025', -- Горгона
	'g000uu6113', -- Оккультист
}

------------------------------------------------------------------------------------------------------------------------
--- Шаблоны Сущностей
------------------------------------------------------------------------------------------------------------------------
---- Шаблон:Локация
function absLocation()
	return {
		--size = LocSize.x1,
	}
end

--- Шаблон:Зона
function absZone(id, size)
	return {
		id = id,
		size = size,
		type = Zone.Junction,
		--fill = Fill.Mountain,
		border = Border.Closed,
		-------------------------
		--- только для столицы
		-------------------------
		--race = race,
		--capital = absCapital(),
		-------------------------
		towns = {},
		mines = {},
		bags = {},
		stacks = {},
		ruins = {},
		merchants = {},
		mercenaries = {},
		mages = {},
		trainers = {},
		resourceMarkets = {},
	}
end

--- Шаблон:Лут
function absLoot()
	return {
		itemTypes = {},
		value = {min = 0, max = 0},
		itemValue = {min = 0, max = 0},
		items = {},
		forbiddenIds = {},
	}
end

--- Шаблон:Столица
function absCapital(race)
	return {
		name = '',
		aiPriority = 0,
		gapMask = 15,
		buildings = {},
		spells = {},
		garrison = {
			subraceTypes = {getSubraceByRace(race)},
			value = {min = 0, max = 0},
			loot = absLoot(),
		},
		location = absLocation(),
	}
end

--- Шаблон:Город
function absTown()
	return {
		name = '',
		tier = 1,
		aiPriority = 0,
		gapMask = 15,
		stack = absStack(),
		garrison = {
			subraceTypes = {},
			value = {min = 0, max = 0},
			loot = absLoot(),
			forbiddenIds = {},
		},
		regen = 0,
		growthTurn = 0,
		riotTurn = 0,
		protectionId = '',
		location = absLocation(),
	}
end

--- Шаблон:Лавка Торговеца
function absMerchant()
	return {
		name = '',
		description = '',
		goods = absLoot(),
		guard = absStack(),
		location = absLocation(),
	}
end

--- Шаблон:Лавка Мага
function absMage()
	return {
		name = '',
		description = '',
		spells = {},
		spellTypes = {},
		spellLevel = {min = 1, max = 5},
		value = {min = 0, max = 0},
		guard = absStack(),
		forbiddenIds = {},
		location = absLocation(),
	}
end

--- Шаблон:Лагерь Наемников
function absMercenary()
	return {
		name = '',
		description = '',
		units = {},
		subraceTypes = {},
		value = {min = 0, max = 0},
		enrollValue = {min = 0, max = 0},
		guard = absStack(),
		unique = true,
		duplicate = true,
		forbiddenIds = {},
		location = absLocation(),
	}
end

--- Шаблон:Тренер
function absTrainer()
	return {
		name = '',
		description = '',
		guard = absStack(),
		location = absLocation(),
	}
end

--- Шаблон:Рынок Ресурсов
function absMarket()
	return {
		name = '',
		description = '',
		exchangeRates = [[]],
		stock = {
			{ resource = Resource.Gold, value = { min = 0, max = 0 }, infinity = false},
			{ resource = Resource.LifeMana, value = { min = 0, max = 0 }, infinity = false},
			{ resource = Resource.DeathMana, value = { min = 0, max = 0 }, infinity = false},
			{ resource = Resource.InfernalMana, value = { min = 0, max = 0 }, infinity = false},
			{ resource = Resource.RunicMana, value = { min = 0, max = 0 }, infinity = false},
			{ resource = Resource.GroveMana, value = { min = 0, max = 0 }, infinity = false},
		},
		guard = absStack(),
		location = absLocation(),
	}
end

--- Шаблон:Руины
function absRuin()
	return {
		name = '',
		gold = { min = 0, max = 0 },
		--- Максимум 1 предмет
		loot = absLoot(),
		guard = absStack(),
		location = absLocation(),
	}
end

--- Шаблон:Отряд
function absStack()
	return {
		kef = kef,
		count = 1,
		name = '',
		owner = Race.Neutral,
		order = Order.Stand,
		aiPriority = 0,
		leaderIds = {},
		leaderModifiers = {},
		subraceTypes = rsub(),
		loot = absLoot(),
		forbiddenIds = {},
		location = absLocation(),
	}
end

--- Шаблон:Сундук
function absBags()
	return {
		count = 1,
		aiPriority = 0,
		loot = absLoot(),
		location = absLocation(),
	}
end

--- Шаблон:Рудники
function absMines()
	return {
		gold = 0,
		lifeMana = 0,
		runicMana = 0,
		deathMana = 0,
		infernalMana = 0,
		groveMana = 0,
	}
end

------------------------------------------------------------------------------------------------------------------------
--- Контент зон
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
--- Контент:Cтолица
------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
local BUILDINGS = {
	EMPIRE = {
		L_FIGHTER = {
			{'g000bb0001', 'g000bb0002', 'g000bb0003', 'g000bb0004'}, -- Мастер клинка + Хранитель Ордена
			{'g000bb0001', 'g000bb0002', 'g000bb0003', 'g000bb0005'}, -- Паладин + Кастелян
			{'g000bb0001', 'g000bb0002', 'g000bb0006'},               -- Ангел + Сенешаль
			{'g000bb0007', 'g000bb0008', 'g000bb0009'},               -- Великий Инквизитор + Эмиссар
			{'g000bb0136', 'g000bb0137', 'g000bb0138', 'g000bb0139'}, -- Фанатик + Игнар
		},
		L_ARCHER = {
			{'g000bb0010', 'g000bb0011', 'g000bb0190'}, -- Юстициар
			{'g000bb0010', 'g000bb0131', 'g000bb0132'}, -- Кара Императора
			{'g000bb0170', 'g000bb0171'},               -- Бореалис
		},
		L_MAGE = {
			{'g000bb0012', 'g000bb0013', 'g000bb0014'},               -- Белый Маг
			--{'g000bb0012', 'g000bb0015', 'g000bb0143', 'g000bb0154'}, -- Демиург #SUMMONER
			{'g000bb0012', 'g000bb0182', 'g000bb0183'},               -- Криомант
		},
		L_SPECIAL = {
			{'g000bb0016', 'g000bb0017', 'g000bb0018'}, -- Патриарх
			{'g000bb0016', 'g000bb0168', 'g000bb0169'}, -- Епископ
			{'g000bb0019', 'g000bb0020', 'g000bb0021'}, -- Прорицательница
		},
		L_SIDESHOW = {
			{'g000bb0022', 'g000bb0192'}, -- Рефаим
		},
	},
	CLANS = {
		L_FIGHTER = {
			{'g000bb0026', 'g000bb0027', 'g000bb0028', 'g000bb0029'}, -- Ярл + Гарм
			{'g000bb0026', 'g000bb0027', 'g000bb0028', 'g000bb0030'}, -- Конунг + Гарм
			{'g000bb0026', 'g000bb0027', 'g000bb0133'},               -- Хранитель рун + Гарм
			{'g000bb0026', 'g000bb0031', 'g000bb0032', 'g000bb0158'}, -- Жрец Имира + Белый волк
			--{'g000bb0026', 'g000bb0031', 'g000bb0033'},               -- Повелитель волков + Белый волк #SUMMONER
		},
		L_ARCHER = {
			{'g000bb0034', 'g000bb0035'},               -- Защитник горна
			{'g000bb0034', 'g000bb0036', 'g000bb0142'}, -- Метатель Огня
			{'g000bb0034', 'g000bb0175'},               -- Сотрясатель
		},
		L_MAGE = {
			{'g000bb0037', 'g000bb0038', 'g000bb0039'}, -- Архидруид
			{'g000bb0037', 'g000bb0040', 'g000bb0172'}, -- Эйра
			{'g000bb0037', 'g000bb0173', 'g000bb0174'}, -- Хейса
		},
		L_SPECIAL = {
			{'g000bb0041', 'g000bb0042', 'g000bb0043'},               -- Повелитель Бурь
			{'g000bb0041', 'g000bb0149', 'g000bb0150'},               -- Сын земли
			{'g000bb0041', 'g000bb0044', 'g000bb0045', 'g000bb0123'}, -- Гримтурс
		},
		L_SIDESHOW = {
			{'g000bb0046', 'g000bb0189'}, -- Йамму
		},
	},
	LEGIONS = {
		L_FIGHTER = {
			{ 'g000bb0050', 'g000bb0051', 'g000bb0052' }, -- Возвышенный
			{ 'g000bb0050', 'g000bb0051', 'g000bb0159' }, -- Искоренитель
			{ 'g000bb0050', 'g000bb0125', 'g000bb0126' }, -- Истязатель душ
		},
		L_ARCHER = {
			{ 'g000bb0053', 'g000bb0054' }, -- Ониксовая
			{ 'g000bb0053', 'g000bb0162' }, -- Азуритовая
			{ 'g000bb0176', 'g000bb0177' }, -- Чароитовая
			{ 'g000bb0176', 'g000bb0178' }, -- Цитриновая
		},
		L_MAGE = {
			{ 'g000bb0055', 'g000bb0056', 'g000bb0057', 'g000bb0058' }, -- Модеус
			{ 'g000bb0055', 'g000bb0056', 'g000bb0057', 'g000bb0153' }, -- Барантор
			{ 'g000bb0055', 'g000bb0056', 'g000bb0060', 'g000bb0140' }, -- Якшини
			--{ 'g000bb0055', 'g000bb0059', 'g000bb0157' },               -- Хозяин масок #SUMMONER
			{ 'g000bb0061', 'g000bb0062', 'g000bb0063' },               -- Суккуб
		},
		L_SPECIAL = {
			{ 'g000bb0064', 'g000bb0065', 'g000bb0066', 'g000bb0067' }, -- Тиамат
			{ 'g000bb0064', 'g000bb0065', 'g000bb0068', 'g000bb0069' }, -- Владыка
			{ 'g000bb0064', 'g000bb0065', 'g000bb0068', 'g000bb0070' }, -- Демон бездны
			{ 'g000bb0064', 'g000bb0065', 'g000bb0144', 'g000bb0145' }, -- Багряный ангел
		},
		L_SIDESHOW = {
			{ 'g000bb0071', 'g000bb0181' }, -- Сатир
		},
		L_CUSTOM = {
			{ 'g000bb0186' }, -- Ведьмино отродье
		},
	},
	UNDEAD = {
		L_FIGHTER = {
			{'g000bb0075', 'g000bb0076', 'g000bb0077', 'g000bb0078'}, -- Воин-призрак
			{'g000bb0075', 'g000bb0076', 'g000bb0077', 'g000bb0146'}, -- Черный рыцарь
			{'g000bb0079', 'g000bb0080', 'g000bb0163'},               -- Клеврет смерти
		},
		L_ARCHER = {
			{'g000bb0081', 'g000bb0082'},               -- Тень
			{'g000bb0081', 'g000bb0129', 'g000bb0130'}, -- Длань Мортис
			{'g000bb0081', 'g000bb0161'},               -- Эльф-призрак
		},
		L_MAGE = {
			{'g000bb0083', 'g000bb0084', 'g000bb0085', 'g000bb0086'}, -- Верховный Вампир
			{'g000bb0083', 'g000bb0084', 'g000bb0087', 'g000bb0088'}, -- Архилич
			--{'g000bb0083', 'g000bb0191'},                             -- Теневидец #SUMMONER
			{'g000bb0164', 'g000bb0089', 'g000bb0090', 'g000bb0155'}, -- Драуг
			{'g000bb0164', 'g000bb0089', 'g000bb0091', 'g000bb0141'}, -- Бааванши
		},
		L_SPECIAL = {
			{'g000bb0092', 'g000bb0093', 'g000bb0094'},               -- Вирм + Каган Каменной Пасти
			{'g000bb0092', 'g000bb0093', 'g000bb0095', 'g000bb0127'}, -- Змий разложения + Хан Каменной Пасти
		},
		L_SIDESHOW = {
			{'g000bb0096', 'g000bb0167'}, -- Волколак
			{'g000bb0096', 'g000bb0165'}, -- Чумной оборотень
			{'g000bb0096', 'g000bb0166'}, -- Хорт
		},
	},
	ELVES = {
		L_FIGHTER = {
			{'g000bb0100', 'g000bb0101', 'g000bb0179'}, -- Кераст
			{'g000bb0100', 'g000bb0134', 'g000bb0156'}, -- Штормовой кентавр
			{'g000bb0102', 'g000bb0180'},               -- Кентавр-гвардеец
		},
		L_ARCHER = {
			{'g000bb0103', 'g000bb0104'},                             -- Стингер
			{'g000bb0103', 'g000bb0105', 'g000bb0121', 'g000bb0122'}, -- Мародер
			{'g000bb0103', 'g000bb0105', 'g000bb0135', 'g000bb0152'}, -- Кокильяр
			{'g000bb0106', 'g000bb0107'},                             -- Стражник
			{'g000bb0106', 'g000bb0108'},                             -- Часовой
		},
		L_MAGE = {
			{'g000bb0109', 'g000bb0110'},               -- Тиург
			{'g000bb0109', 'g000bb0111'},               -- Архонт
			{'g000bb0109', 'g000bb0151', 'g000bb0160'}, -- Консул
		},
		L_SPECIAL = {
			{'g000bb0112', 'g000bb0113', 'g000bb0114', 'g000bb0115'}, -- Сильфида
			{'g000bb0112', 'g000bb0113', 'g000bb0124'},               -- Целитель
			{'g000bb0112', 'g000bb0113', 'g000bb0148'},               -- Дриолисса
		},
		L_SIDESHOW = {
			{'g000bb0116', 'g000bb0117', 'g000bb0147'}, -- Владыка Небес
		},
	},
}
function getBuildings(race)
	local buildings = {}
	if emd({false, false, true, true}) then
		for _, raceData in pairs(BUILDINGS) do
			for _, categoryVariants in pairs(raceData) do
				local chosen = categoryVariants[math.random(#categoryVariants)]
				for _, id in pairs(chosen) do
					table.insert(buildings, id)
				end
			end
		end
	end
	return buildings
end

function getCapital0(race)
	---
	local capital = absCapital(race)

	capital.garrison.value = {min = 50, max = 50}
	capital.buildings = getBuildings(race)

	Distributor:requestTownData(capital, Pools.objects.capitals.t0, race)

	Distributor:requestItems(capital.garrison, Pools.capital.fix_perk, 1, race)
	Distributor:requestItems(capital.garrison, Pools.capital.fix_heal, 5, race)

	Distributor:requestItems(capital.garrison, Pools.capital.fix_buff_1, 4, race)
	Distributor:requestItems(capital.garrison, Pools.capital.rnd_buff_1, 2, race)

	Distributor:requestItems(capital.garrison, Pools.capital.fix_ward_1, 3, race)
	Distributor:requestItems(capital.garrison, Pools.capital.rnd_ward_1, 1, race)
	Distributor:requestItems(capital.garrison, Pools.capital.rnd_ward_2, 1, race)

	Distributor:requestItems(capital.garrison, Pools.capital.fix_ward_el, 4, race)
	Distributor:requestItems(capital.garrison, Pools.capital.rnd_ward_el, 2, race)
	Distributor:requestItems(capital.garrison, Pools.capital.rnd_ward_dot, 2, race)

	Distributor:requestItems(capital.garrison, Pools.capital.rnd_sphere_1, 1, race)
	Distributor:requestItems(capital.garrison, Pools.capital.rnd_sphere_2, 1, race)

	Distributor:requestItems(capital.garrison, Pools.capital.rnd_scrolls_1, 1, race)
	Distributor:requestItems(capital.garrison, Pools.capital.rnd_scrolls_2, 1, race)

	Distributor:requestItems(capital.garrison, Pools.capital.rnd_bonus, 1, race)
	Distributor:requestItems(capital.garrison, Pools.capital.rnd_equip, 1, race)

	Distributor:requestItems(capital.garrison, Pools.loot.t0.talisman, 1, race)

	Distributor:requestItems(capital.garrison, Pools.items.mana.special.normal, 1, race)

	Distributor:requestSpells(capital, Pools.spells.capital, 1, race)

	return capital
end
------------------------------------------------------------------------------------------------------------------------
--- Контент:Города
------------------------------------------------------------------------------------------------------------------------
--- т1
function getTowns1(race)
	local towns = {}
	local i = 1

	--- 240
	towns[i] = absTown()
	Distributor:requestTownData(towns[i], Pools.objects.towns.t1)

	towns[i].stack = absStack()
	towns[i].stack.value = getStackValue(towns[i].stack, 240)
	towns[i].stack.loot.itemTypes = {Item.Scroll, Item.Orb}
	towns[i].stack.loot.value = {min = 400, max = 400}
	towns[i].stack.loot.itemValue = {min = 400, max = 400}
	Distributor:requestItems(towns[i].stack, rnd(Pools.items.perks.pool_2a, Pools.items.perks.pool_2b), 1, race)

	Distributor:requestItems(towns[i].stack, Pools.loot.t1.res, 1, race)
	Distributor:requestItems(towns[i].stack, Pools.loot.t1.heal, 2, race)

	Distributor:requestItems(towns[i].stack, rnd(Pools.items.mana.special.normal, Pools.loot.t1.gold), 1, race)

	Distributor:requestItems(towns[i].stack, Pools.items.buff_1, math.random(0,1))
	Distributor:requestItems(towns[i].stack, Pools.items.buff_e2, 1)

	i = i + 1

	return towns
end

--- т2
function getTowns2(race)
	local towns = {}
	local i = 1

	--- 450
	towns[i] = absTown()
	Distributor:requestTownData(towns[i], Pools.objects.towns.t2)

	towns[i].stack = absStack()
	towns[i].stack.subraceTypes = rsub(true)
	towns[i].stack.value = getStackValue(towns[i].stack, 450)

	towns[i].stack.loot.itemTypes = {Item.Scroll, Item.Orb}
	towns[i].stack.loot.value = {min = 500, max = 650}
	towns[i].stack.loot.itemValue = {min = 450, max = 650}
	Distributor:requestItems(towns[i].stack, Pools.loot.t2.heal_1, 1, race)
	Distributor:requestItems(towns[i].stack, Pools.loot.t2.heal_2, 2, race)
	Distributor:requestItems(towns[i].stack, Pools.loot.t2.buff_3, 1, race)
	Distributor:requestItems(towns[i].stack, rnd(
			Pools.items.buff_1,
			Pools.items.ward_el,
			Pools.loot.t2.buff_3
	), 1, race)
	Distributor:requestItems(towns[i].stack, rnd(
			Pools.items.mana.normal,
			Pools.items.mana.special.normal,
			Pools.loot.t2.gold
	), 1, race)
	Distributor:requestItems(towns[i].stack, Pools.loot.t2.permo_2, 1, race)
	Distributor:requestItems(towns[i].stack, Pools.loot.t2.scrolls_2, 1, race)
	Distributor:requestItems(towns[i].stack, Pools.items.perks.pool_3, 1, race)

	i = i + 1

	return towns
end

--- т4
function getTowns4()
	local towns = {}
	local i = 1

	--- 1100
	towns[i] = absTown()
	Distributor:requestTownData(towns[i], Pools.objects.towns.t4)

	towns[i].stack = absStack()
	towns[i].stack.subraceTypes = { Subrace.NeutralDragon, Subrace.Human, Subrace.Heretic, Subrace.Dwarf, Subrace.Elf }
	towns[i].stack.value = getStackValue(towns[i].stack, 1100)

	towns[i].stack.loot.itemTypes = {Item.Scroll, Item.Orb}
	towns[i].stack.loot.value = {min = 700, max = 820}
	towns[i].stack.loot.itemValue = {min = 700, max = 800}
	Distributor:requestItems(towns[i].stack, Pools.loot.t4.res, 1)
	Distributor:requestItems(towns[i].stack, Pools.loot.t4.heal, 3)
	Distributor:requestItems(towns[i].stack, rnd(
			Pools.items.mana.big,
			Pools.loot.t4.gold
	), 1)
	Distributor:requestItems(towns[i].stack, rnd(
			Pools.items.buff_2,
			Pools.loot.t4.buff_2
	), 1)
	Distributor:requestItems(towns[i].stack, Pools.loot.t4.permo_1, 1)
	Distributor:requestItems(towns[i].stack, Pools.loot.t4.staff, 1)

	i = i + 1

	return towns
end
------------------------------------------------------------------------------------------------------------------------
--- Контент:Руины
------------------------------------------------------------------------------------------------------------------------
--- т0
function getRuins0(race)
	local ruins = {}
	local i = 1
	local zone_kef = 1.0

	--- 160 / 250-300
	ruins[i] = absRuin()
	Distributor:requestRuinData(ruins[i], Pools.objects.ruins.t0)
	ruins[i].guard = absStack()
	ruins[i].guard.kef = zone_kef
	ruins[i].guard.value = getStackValue(ruins[i].guard, 160)
	ruins[i].guard.forbiddenIds = forbidden.ruins
	ruins[i].gold = {min = 225, max = 275}
	local placed = tryPlaceSetItem(ruins[i], 'g002ig0001', ruinsLootTypes[1], 0.5)
	if not placed then
		Distributor:requestItemsAdvanced(ruins[i], Pools.items.ruins.t0, 1, {types = {ruinsLootTypes[1]}, race = race})
	end
	i = i + 1
	--- 160 / 200-250
	ruins[i] = absRuin()
	Distributor:requestRuinData(ruins[i], Pools.objects.ruins.t0)
	ruins[i].guard = absStack()
	ruins[i].guard.kef = zone_kef
	ruins[i].guard.value = getStackValue(ruins[i].guard, 160)
	ruins[i].guard.forbiddenIds = forbidden.ruins
	ruins[i].gold = {min = 225, max = 275}
	ruins[i].loot.items = {}
	placed = tryPlaceSetItem(ruins[i], 'g002ig0001', ruinsLootTypes[2], 0.5)
	if not placed then
		Distributor:requestItemsAdvanced(ruins[i], Pools.items.ruins.t0, 1, {types = {ruinsLootTypes[2]}, race = race})
	end
	i = i + 1

	return ruins
end

--- т1
function getRuins1(race)
	local ruins = {}
	local i = 1

	--- 240 / 300-350
	ruins[i] = absRuin()
	Distributor:requestRuinData(ruins[i], Pools.objects.ruins.t1)
	ruins[i].guard = absStack()
	ruins[i].guard.value = getStackValue(ruins[i].guard, 240)
	ruins[i].guard.forbiddenIds = forbidden.ruins
	ruins[i].gold = {min = 300, max = 350}
	local placed = tryPlaceSetItem(ruins[i], 'g002ig0002', ruinsLootTypes[3], 0.5)
	if not placed then
		placed = tryPlaceSetItem(ruins[i], 'g001ig0602', ruinsLootTypes[3], 0.5)
	end
	if not placed then
		Distributor:requestItemsAdvanced(ruins[i], Pools.items.ruins.t1, 1, {types = {ruinsLootTypes[3]}, race = race})
	end
	i = i + 1

	return ruins
end

--- т2
function getRuins2()
	local ruins = {}
	local i = 1

	--- 400 / 350-400
	ruins[i] = absRuin()
	Distributor:requestRuinData(ruins[i], Pools.objects.ruins.t2)
	ruins[i].guard = absStack()
	ruins[i].guard.subraceTypes = rsub(true)
	ruins[i].guard.value = getStackValue(ruins[i].guard, 400)
	ruins[i].guard.forbiddenIds = forbidden.ruins
	ruins[i].gold = {min = 350, max = 400}
	local placed = tryPlaceSetItem(ruins[i], 'g001ig0603', ruinsLootTypes[4], 0.5)
	if not placed then
		Distributor:requestItemsAdvanced(ruins[i], Pools.items.ruins.t2, 1, {types = {ruinsLootTypes[4]}, race = race})
	end
	i = i + 1

	return ruins
end

--- т3
function getRuins3(types)
	local ruins = {}
	local i = 1

	local availableSetItems = {}
    for id, config in pairs(setItemsConfig) do
        if not setItemsStatus[id] and config.ruins and isTableContains(config.ruins, 't3') then
            table.insert(availableSetItems, id)
        end
    end

	--- 900 / 400-450
	for _, typeName in ipairs(types) do
		ruins[i] = absRuin()
		Distributor:requestRuinData(ruins[i], Pools.objects.ruins.t3)
		ruins[i].guard = absStack()
		ruins[i].guard.subraceTypes = rsub(true)
		ruins[i].guard.value = getStackValue(ruins[i].guard, 900)
		ruins[i].guard.forbiddenIds = forbidden.ruins
		ruins[i].gold = {min = 400, max = 450}

		local placed = false
		if #availableSetItems > 0 then
			shake(availableSetItems)
			for _, itemId in ipairs(availableSetItems) do
				if tryPlaceSetItem(ruins[i], itemId, nil, 0.5) then
					placed = true
					break
				end
			end
		end

		if not placed then
			Distributor:requestItems(ruins[i], Pools.items.ruins.t3[typeName], 1)
		end
		i = i + 1
	end

	return ruins
end

--- т4
function getRuins4()
	local ruins = {}
	local i = 1

	local availableSetItems = {}
	for id, config in pairs(setItemsConfig) do
		if not setItemsStatus[id] and config.ruins and isTableContains(config.ruins, 't4') then
			table.insert(availableSetItems, id)
		end
	end

	--- 1400-1500 / 450-500
	for _ = 1, 2 do
		ruins[i] = absRuin()
		Distributor:requestRuinData(ruins[i], Pools.objects.ruins.t4)
		ruins[i].guard = absStack()
		ruins[i].guard.subraceTypes = rsub(true)
		ruins[i].guard.value = getStackValue(ruins[i].guard, 1400, 1500)
		ruins[i].guard.forbiddenIds = forbidden.ruins
		ruins[i].gold = {min = 450, max = 500}

		local placed = false
		if #availableSetItems > 0 then
			shake(availableSetItems)
			for _, itemId in ipairs(availableSetItems) do
				if tryPlaceSetItem(ruins[i], itemId, nil, 0.5) then
					placed = true
					break
				end
			end
		end

		if not placed then
			Distributor:requestItems(ruins[i], Pools.items.ruins.t4.r1, 1)
		end
		i = i + 1
	end

	return ruins
end

--- т5
function getRuins5()
	local ruins = {}
	local i = 1

	local availableSetItems = {}
	for id, config in pairs(setItemsConfig) do
		if not setItemsStatus[id] and config.ruins and isTableContains(config.ruins, 't5') then
			table.insert(availableSetItems, id)
		end
	end

	--- 1600-1700 / 500-550
	for _ = 1, 2 do
		ruins[i] = absRuin()
		Distributor:requestRuinData(ruins[i], Pools.objects.ruins.t5)
		ruins[i].guard = absStack()
		ruins[i].guard.subraceTypes = rsub(true)
		ruins[i].guard.value = getStackValue(ruins[i].guard, 1600, 1700)
		ruins[i].guard.forbiddenIds = forbidden.ruins
		ruins[i].gold = {min = 500, max = 550}

		local placed = false
		if #availableSetItems > 0 then
			shake(availableSetItems)
			for _, itemId in ipairs(availableSetItems) do
				if tryPlaceSetItem(ruins[i], itemId, nil, 0.5) then
					placed = true
					break
				end
			end
		end

		if not placed then
			Distributor:requestItems(ruins[i], Pools.items.ruins.t4.r1, 1)
		end
		i = i + 1
	end

	return ruins
end

------------------------------------------------------------------------------------------------------------------------
--- Контент:Отряды
------------------------------------------------------------------------------------------------------------------------
--- т0
function getStacks0(race)
	local stacks = {}
	local i = 1
	local zone_kef = 1.0
	--- 140*2
	stacks[i] = absStack()
	stacks[i].subraceTypes = {Subrace.NeutralGreenSkin, Subrace.NeutralWolf}
	stacks[i].kef = zone_kef
	stacks[i].count = 2
	stacks[i].value = getStackValue(stacks[i], 140)
	Distributor:requestItems(stacks[i], Pools.loot.t0.heal, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t0.ward_el, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t0.talisman, 1, race)

	Distributor:requestItems(stacks[i], Pools.items.mana.small, 1)

	i = i + 1

	--- 150*2
	stacks[i] = absStack()
	stacks[i].kef = zone_kef
	stacks[i].count = 2
	stacks[i].value = getStackValue(stacks[i], 150)
	Distributor:requestItems(stacks[i], Pools.loot.t0.heal, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t0.ward_el, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t0.talisman, 1, race)

	Distributor:requestItems(stacks[i], Pools.items.buff_1, 1)
	i = i + 1

	--- 160*2
	stacks[i] = absStack()
	stacks[i].kef = zone_kef
	stacks[i].count = 2
	stacks[i].value = getStackValue(stacks[i], 160)
	stacks[i].loot = {
		itemTypes = { Item.Orb },
		value = { min = 200, max = 200 },
		itemValue = { min = 100, max = 100 },
	}
	Distributor:requestItems(stacks[i], Pools.loot.t0.heal, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t0.orb, 1, race)

	Distributor:requestItems(stacks[i], Pools.items.buff_1, 1)
	i = i + 1

	--- 170*2
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].kef = zone_kef
	stacks[i].count = 2
	stacks[i].value = getStackValue(stacks[i], 170)
	stacks[i].loot = {
		itemTypes = { Item.Scroll },
		value = { min = 400, max = 400 },
		itemValue = { min = 200, max = 200 },
	}
	Distributor:requestItems(stacks[i], Pools.loot.t0.res, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t0.heal, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t0.scroll, 1, race)
	Distributor:requestItems(stacks[i], rnd(Pools.items.mana.special.small, Pools.items.mana.small), 1)
	i = i + 1

	--- 180*1
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].kef = zone_kef
	stacks[i].value = getStackValue(stacks[i], 180)
	Distributor:requestItems(stacks[i], Pools.loot.t0.res, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t0.heal, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t0.ward_2, 1, race)
	i = i + 1

	return stacks
end

--- т1
function getStacks1(race)
	local stacks = {}
	local i = 1

	--- 200*2
	stacks[i] = absStack()
	stacks[i].subraceTypes = {Subrace.NeutralGreenSkin, Subrace.NeutralWolf}
	stacks[i].count = 2
	stacks[i].value = getStackValue(stacks[i], 200)
	Distributor:requestItems(stacks[i], Pools.loot.t1.heal, 2, race)
	Distributor:requestItems(stacks[i], Pools.loot.t1.gold, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t1.ward_el, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t0.buff_1, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t1.talisman, 1, race)
	Distributor:requestItems(stacks[i], Pools.items.mana.small, 1)
	i = i + 1

	--- 220*2
	stacks[i] = absStack()
	stacks[i].count = 2
	stacks[i].value = getStackValue(stacks[i], 220)
	Distributor:requestItems(stacks[i], Pools.loot.t1.heal, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t1.ward_el, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t0.buff_1, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t0.orb, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t1.orb, 2, race)
	i = i + 1

	--- 240*2
	stacks[i] = absStack()
	stacks[i].count = 2
	stacks[i].value = getStackValue(stacks[i], 240)
	Distributor:requestItems(stacks[i], Pools.loot.t1.heal, 2, race)
	Distributor:requestItems(stacks[i], Pools.loot.t1.ward_el, 1, race)
	Distributor:requestItems(stacks[i], Pools.items.mana.small, 1)

	i = i + 1

	--- 280*1
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].count = 1
	stacks[i].value = getStackValue(stacks[i], 280)
	Distributor:requestItems(stacks[i], Pools.loot.t1.heal, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t1.ward_2, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t1.permo_1, 1, race)
	Distributor:requestItems(stacks[i], Pools.items.buff_1, 1)
	i = i + 1

	--- 300*1
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].value = getStackValue(stacks[i], 300)
	Distributor:requestItems(stacks[i], Pools.loot.t1.heal, 2, race)
	Distributor:requestItems(stacks[i], Pools.loot.t1.scrolls, 1, race)
	Distributor:requestItems(stacks[i], Pools.items.ward_el, 1)
	Distributor:requestItems(stacks[i], Pools.items.buff_e2, 1)
	i = i + 1

	--- 320*1
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].value = getStackValue(stacks[i], 320)
	Distributor:requestItems(stacks[i], Pools.loot.t1.heal, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t1.talisman, 1, race)
	Distributor:requestItems(stacks[i], Pools.items.ward_dot, 1)

	i = i + 1

	return stacks
end

--- т2
function getStacks2(race)
	local stacks = {}
	local i = 1

	--- 300*2
	stacks[i] = absStack()
	stacks[i].count = 2
	stacks[i].value = getStackValue(stacks[i], 300)

	Distributor:requestItems(stacks[i], Pools.items.buff_1, 1)
	Distributor:requestItems(stacks[i], Pools.items.mana.normal, 1)

	Distributor:requestItems(stacks[i], rnd(Pools.loot.t2.heal_1, Pools.loot.t2.heal_2), 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t2.heal_2, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t2.gold, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t2.ward_3, 1, race)
	i = i + 1

	--- 400*2
	stacks[i] = absStack()
	stacks[i].count = 2
	stacks[i].value = getStackValue(stacks[i], 400)
	Distributor:requestItems(stacks[i], rnd(Pools.loot.t2.heal_1, Pools.loot.t2.heal_2), 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t2.heal_2, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t2.ward_2, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t2.buff_2, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t2.orb, 2)
	i = i + 1

	--- 500*2
	stacks[i] = absStack()
	stacks[i].count = 2
	stacks[i].value = getStackValue(stacks[i], 500)
	Distributor:requestItems(stacks[i], rnd(Pools.loot.t2.heal_1, Pools.loot.t2.heal_2), 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t2.heal_2, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t2.ward_2, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t2.perk, 1, race)
	Distributor:requestItems(stacks[i], Pools.goods.t2.scrolls_1, 2)
	Distributor:requestItems(stacks[i], Pools.items.mana.normal, 1)
	i = i + 1

	--- 550*1
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].value = getStackValue(stacks[i], 550)
	Distributor:requestItems(stacks[i], Pools.loot.t2.heal_2, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t2.ward_2, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t2.permo_1, 1, race)
	Distributor:requestItems(stacks[i], Pools.items.ward_el, 1)
	i = i + 1

	--- 575*1
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].value = getStackValue(stacks[i], 575)
	Distributor:requestItems(stacks[i], rnd(Pools.loot.t2.heal_1, Pools.loot.t2.heal_2), 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t2.heal_2, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t2.permo_2, 1)
	Distributor:requestItems(stacks[i], Pools.loot.t2.buff_2, 1, race)
	i = i + 1

	--- 600*1
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].value = getStackValue(stacks[i], 600)
	Distributor:requestItems(stacks[i], Pools.loot.t2.heal_2, 1, race)
	Distributor:requestItems(stacks[i], rnd(Pools.loot.t2.talisman, Pools.loot.t2.gold), 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t2.permo_3, 1)
	Distributor:requestItems(stacks[i], Pools.items.buff_1, 1)
	i = i + 1

	return stacks
end

--- т3
function getStacks3(race)
	local stacks = {}
	local i = 1

	--- 600*2
	stacks[i] = absStack()
	stacks[i].count = 2
	stacks[i].value = getStackValue(stacks[i], 600)
	Distributor:requestItems(stacks[i], Pools.loot.t3.heal_1, 2, race)
	Distributor:requestItems(stacks[i], Pools.loot.t3.heal_2, 2, race)
	Distributor:requestItems(stacks[i], Pools.loot.t3.misc_1, 2, race)
	Distributor:requestItems(stacks[i], rnd(
			Pools.loot.t3.permo_3,
			Pools.loot.t3.staff_1
	), 1)
	Distributor:requestItems(stacks[i], rnd(
			Pools.items.buff_1,
			Pools.items.ward_el
	), 1)
	Distributor:requestItems(stacks[i], rnd(
			Pools.items.buff_1,
			Pools.items.ward_el
	), 1)
	i = i + 1

	--- 700*1
	stacks[i] = absStack()
	stacks[i].count = 2
	stacks[i].value = getStackValue(stacks[i], 700)
	Distributor:requestItems(stacks[i], Pools.loot.t3.heal_1, 2, race)
	Distributor:requestItems(stacks[i], Pools.loot.t3.heal_2, 3, race)
	Distributor:requestItems(stacks[i], Pools.loot.t3.buff_2, 1)
	Distributor:requestItems(stacks[i], rnd(
			Pools.items.buff_1,
			Pools.items.ward_el,
			Pools.items.ward_dot,
			Pools.items.ward_1
	), 3)
	i = i + 1

	--- 750*1
	stacks[i] = absStack()
	stacks[i].value = getStackValue(stacks[i], 750)
	stacks[i].loot.itemTypes = { Item.Orb }
	stacks[i].loot.value = { min = 600, max = 600 }
	stacks[i].loot.itemValue = { min = 500, max = 600 }
	Distributor:requestItems(stacks[i], Pools.loot.t3.heal_1, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t3.heal_2, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t3.heal_3, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t3.buff_3, 1)
	i = i + 1

	--- 800*1
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].value = getStackValue(stacks[i], 800)
	Distributor:requestItems(stacks[i], Pools.loot.t3.heal_3, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t3.heal_4, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t3.buff_4, 1)
	Distributor:requestItems(stacks[i], Pools.loot.t3.orb, 1)
	Distributor:requestItems(stacks[i], Pools.loot.t3.scroll, 1)
	i = i + 1

	--- 1100*1
	stacks[i] = absStack()
	stacks[i].subraceTypes = { Subrace.NeutralDragon, Subrace.Human, Subrace.Heretic, Subrace.Dwarf, Subrace.Elf }
	stacks[i].value = getStackValue(stacks[i], 1100)
	Distributor:requestItems(stacks[i], Pools.loot.t3.heal_2, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t3.heal_6, 2, race)
	Distributor:requestItems(stacks[i], Pools.loot.t3.heal_7, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t3.misc_2, 1, race)
	Distributor:requestItems(stacks[i], rnd(
			Pools.loot.t3.talisman,
			Pools.loot.t3.permo_2
	), 1)
	i = i + 1

	return stacks
end

--- т4
function getStacks4(race)
	local stacks = {}
	local i = 1

	--- 1100*1
	stacks[i] = absStack()
	stacks[i].subraceTypes = { Subrace.NeutralDragon, Subrace.Human, Subrace.Heretic, Subrace.Dwarf, Subrace.Elf }
	stacks[i].value = getStackValue(stacks[i], 1100)
	Distributor:requestItems(stacks[i], Pools.loot.t3.heal_2, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t3.heal_6, 2, race)
	Distributor:requestItems(stacks[i], Pools.loot.t3.heal_7, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t3.misc_2, 1, race)
	Distributor:requestItems(stacks[i], rnd(
			Pools.loot.t3.talisman,
			Pools.loot.t3.permo_2
	), 1)
	i = i + 1

	return stacks
end

--- т5
function getStacks5(race)
	local stacks = {}
	local i = 1

	--- 1300*1 -- 1
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].value = getStackValue(stacks[i], 1300)
	Distributor:requestItems(stacks[i], Pools.loot.t5.heal, 3, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.gold_1, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.art, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.staff, 1)
	Distributor:requestItems(stacks[i], Pools.items.mana.normal, 1)
	i = i + 1

	--- 1300*1 -- 2
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].value = getStackValue(stacks[i], 1300)
	Distributor:requestItems(stacks[i], Pools.loot.t5.heal, 3, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.gold_1, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.boots, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.staff, 1)
	Distributor:requestItems(stacks[i], Pools.loot.t5.scroll, 1)
	i = i + 1

	--- 1300*1 -- 3
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].value = getStackValue(stacks[i], 1300)
	Distributor:requestItems(stacks[i], Pools.loot.t5.heal, 3, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.gold_2, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.banner, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.staff, 1)
	Distributor:requestItems(stacks[i], Pools.loot.t5.orb, 1)
	i = i + 1

	--- 1300*1 -- 4
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].value = getStackValue(stacks[i], 1300)
	Distributor:requestItems(stacks[i], Pools.loot.t5.heal, 3, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.gold_2, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.relic, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.staff, 1)
	Distributor:requestItems(stacks[i], Pools.items.buff_e2, 1)
	Distributor:requestItems(stacks[i], Pools.loot.t5.orb, 1)
	i = i + 1

	--- 1600*1
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].value = getStackValue(stacks[i], 1600)
	Distributor:requestItems(stacks[i], Pools.loot.t5.heal, 7, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.gold_3, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.aura_1, 1)
	Distributor:requestItems(stacks[i], Pools.loot.t5.aura_2, 1)
	i = i + 1

	return stacks
end

--- тW
function getStacksW(id)
	local stacks = {}
	local i = 1

	--- 1300*1 waterOnly
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].order = Order.Bezerk
	stacks[i].leaderIds = {'g000uu8138'} -- Русалка
	stacks[i].value = getStackValue(stacks[i], 1300)

	Distributor:requestItems(stacks[i], Pools.loot.t5.heal, 3, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.gold_1, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.art, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.staff, 1)
	Distributor:requestItems(stacks[i], Pools.items.mana.normal, 1)
	i = i + 1

	--- 1300*1 waterOnly
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].order = Order.Bezerk
	stacks[i].leaderIds = {'g000uu5126'} -- Русалка
	stacks[i].value = getStackValue(stacks[i], 1300)

	Distributor:requestItems(stacks[i], Pools.loot.t5.heal, 3, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.gold_1, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.boots, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.staff, 1)
	Distributor:requestItems(stacks[i], Pools.loot.t5.scroll, 1)
	i = i + 1

	--- 1300*1 waterOnly
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].order = Order.Bezerk
	stacks[i].leaderIds = {'g000uu5127'} -- Кракен
	stacks[i].value = getStackValue(stacks[i], 1300)

	Distributor:requestItems(stacks[i], Pools.loot.t5.heal, 3, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.gold_2, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.banner, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.staff, 1)
	Distributor:requestItems(stacks[i], Pools.loot.t5.orb, 2)
	i = i + 1

	--- 1300*1 waterOnly
	stacks[i] = absStack()
	stacks[i].subraceTypes = rsub(true)
	stacks[i].order = Order.Bezerk
	stacks[i].leaderIds = {'g000uu5129'} -- Морской змей
	stacks[i].value = getStackValue(stacks[i], 1300)

	Distributor:requestItems(stacks[i], Pools.loot.t5.heal, 3, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.gold_2, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.relic, 1, race)
	Distributor:requestItems(stacks[i], Pools.loot.t5.staff, 1)
	Distributor:requestItems(stacks[i], Pools.items.buff_e2, 1)
	i = i + 1

	return stacks
end

--- тM
function getStacksM(race1, race2)
	local stacks = {}
	local i = 1

	--- Работник рынка №1
	stacks[i] = absStack()
	stacks[i].owner = race1
	stacks[i].value = getStackValue(stacks[i], 1)
	DistributionSystem:requestLeaders(stacks[i], Pools.leaders.workers_s1, 1)
	i = i + 1

	--- Работник рынка №2
	stacks[i] = absStack()
	stacks[i].owner = race2
	stacks[i].value = getStackValue(stacks[i], 1)
	DistributionSystem:requestLeaders(stacks[i], Pools.leaders.workers_s1, 1)
	i = i + 1

	return stacks
end

------------------------------------------------------------------------------------------------------------------------
--- Контент:ГО
------------------------------------------------------------------------------------------------------------------------
--- т0-1
function getGuard01(race, id)
	local stack = {}
	if id == 1 and emd({false, true, true, false}) then
		if emd({false, true, true, false}) then
			stack = absStack()
			stack.value = { min = 1, max = 1 }
			stack.owner = race
			stack.loot.items = {
				{ id = 'g001ig0128', min = 5, max = 5 }, -- Эликсир защиты от Оружия
			}

			Distributor:requestLeaders(stack, Pools.leaders.bes_t0, 1)

		end
	end
	return stack
end
--- т3-4
function getGuard34(race, id)
	local stack = absStack()
	if id == 1 then
		--- 700*1
		stack.value = getStackValue(stack, 600)
		Distributor:requestItems(stack, Pools.loot.t3.heal_1, 1, race)
		Distributor:requestItems(stack, Pools.loot.t3.heal_2, 1, race)
		Distributor:requestItems(stack, Pools.loot.t3.misc_1, 1, race)
		Distributor:requestItems(stack, rnd(
				Pools.items.buff_1,
				Pools.items.ward_el
		), 1)

	elseif id == 2 then
		--- 850*1
		stack.subraceTypes = rsub(true)
		stack.value = getStackValue(stack, 850)
		Distributor:requestItems(stack, Pools.loot.t3.heal_4, 1, race)
		Distributor:requestItems(stack, Pools.loot.t3.heal_5, 1, race)
		Distributor:requestItems(stack, Pools.loot.t3.permo_1, 1)
		Distributor:requestItems(stack, rnd(
				Pools.loot.t3.talisman,
				Pools.items.mana.normal,
				Pools.items.buff_1,
				Pools.items.ward_el
		), 1)

	elseif id == 3 and emd({false, true, true, false}) then
		--- 850*1
		stack.value = { min = 1, max = 1 }
		stack.owner = race
		stack.order = Order.Roam
		stack.loot.items = {
			{ id = 'g000ig9040', min = 1, max = 1 }, -- Сфера Полиморфа
		}

		Distributor:requestLeaders(stack, Pools.leaders.bes_t3, 1)

	end

	return stack
end

------------------------------------------------------------------------------------------------------------------------
--- Контент:Лавка торговца
------------------------------------------------------------------------------------------------------------------------
--- т1
function getMerchants1(race)
	local merchants = {}
	local i = 1

	---
	merchants[i] = absMerchant()
	Distributor:requestMerchantData(merchants[i], Pools.objects.merchants.t1)

	Distributor:requestItems(merchants[i], Pools.items.perks.pool_1, 1, race)

	Distributor:requestItems(merchants[i], Pools.items.buff_1, 4)
	Distributor:requestItems(merchants[i], Pools.items.buff_1, 2)
	Distributor:requestItems(merchants[i], Pools.items.buff_e1, 2)
	Distributor:requestItems(merchants[i], Pools.items.buff_e2, 1)
	Distributor:requestItems(merchants[i], Pools.items.ward_el, 4)
	Distributor:requestItems(merchants[i], Pools.items.ward_el, 2)
	Distributor:requestItems(merchants[i], Pools.items.ward_1, 1)

	Distributor:requestItems(merchants[i], Pools.goods.t1.heal, 30, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.buff_2, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.permo_stat_1, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.permo_stat_2, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.permo_stat_3, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.artifact_1, 3, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.artifact_2, 3, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.relic_1, 4, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.relic_2, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t1.relic_3, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.boots_1, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t1.boots_2, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.banner, 3, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.talisman, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.sphere_1, 4, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.sphere_2, 2, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.staff_1, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t1.staff_2, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t1.staff_summon, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.scrolls_1_buff, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.scrolls_1_debuff, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.scrolls_heal, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.scrolls_ward, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t1.scrolls_3, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t1.scrolls_2, 2)
	Distributor:requestItems(merchants[i], Pools.goods.t2.scrolls_3, 1, race)
	for id, config in pairs(setItemsConfig) do
		if not setItemsStatus[id] and config.shops and isTableContains(config.shops, 't1') then
			table.insert(merchants[#merchants].goods.items, { id = id, min = 1, max = 1 })
			setItemsStatus[id] = true
		end
	end
	i = i + 1

	return merchants
end

--- т2
function getMerchants2(race)
	local merchants = {}
	local i = 1

	---
	merchants[i] = absMerchant()
	Distributor:requestMerchantData(merchants[i], Pools.objects.merchants.t2)

	Distributor:requestItems(merchants[i], Pools.items.special_equip, 1)
	Distributor:requestItems(merchants[i], Pools.items.perks.pool_1, 1, race)
	Distributor:requestItems(merchants[i], Pools.items.perks.pool_2a, 0, race)
	Distributor:requestItems(merchants[i], Pools.items.perks.pool_3, 1, race)

	Distributor:requestItems(merchants[i], Pools.items.buff_1, 4)
	Distributor:requestItems(merchants[i], Pools.items.buff_1, 2)
	Distributor:requestItems(merchants[i], Pools.items.buff_e2, 1)
	Distributor:requestItems(merchants[i], Pools.items.buff_e2, 1)
	Distributor:requestItems(merchants[i], Pools.items.ward_el, 4)
	Distributor:requestItems(merchants[i], Pools.items.ward_el, 2)
	Distributor:requestItems(merchants[i], Pools.items.ward_dot, 1)
	Distributor:requestItems(merchants[i], Pools.items.ward_1, 1)

	Distributor:requestItems(merchants[i], Pools.goods.t2.heal, 35, race)
	Distributor:requestItems(merchants[i], Pools.goods.t2.buff_2, 3, race)
	Distributor:requestItems(merchants[i], Pools.goods.t2.permo_stat_1, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t2.permo_stat_2, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t2.permo_stat_3, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t2.artifact, 5, race)
	Distributor:requestItems(merchants[i], Pools.goods.t2.relic_1, 3, race)
	Distributor:requestItems(merchants[i], Pools.goods.t2.relic_2, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t2.boots_1, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t2.boots_2, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t2.banner_1, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t2.banner_2, 2)
	Distributor:requestItems(merchants[i], Pools.goods.t2.talisman, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t2.sphere_1, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t2.sphere_2, 3)
	Distributor:requestItems(merchants[i], Pools.goods.t2.staff_1, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t2.staff_2, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t2.scrolls_heal_1, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t2.scrolls_heal_2, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t2.scrolls_summon, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t2.scrolls_1, 2)
	Distributor:requestItems(merchants[i], Pools.goods.t2.scrolls_2, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t2.scrolls_3, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t2.scrolls_4, 1, race)
	Distributor:requestItems(merchants[i], Pools.goods.t2.scrolls_ward, 1)
	for id, config in pairs(setItemsConfig) do
		if not setItemsStatus[id] and config.shops and isTableContains(config.shops, 't2') then
			table.insert(merchants[#merchants].goods.items, { id = id, min = 1, max = 1 })
			setItemsStatus[id] = true
		end
	end
	i = i + 1

	return merchants
end

--- т3
function getMerchants3(id)
	local merchants = {}
	local i = 1

	---
	merchants[i] = absMerchant()
	Distributor:requestMerchantData(merchants[i], Pools.objects.merchants.t3)

	Distributor:requestItems(merchants[i], Pools.items.special_equip, 1)

	Distributor:requestItems(merchants[i], Pools.items.buff_1, 2)
	Distributor:requestItems(merchants[i], Pools.items.buff_1, 2)
	Distributor:requestItems(merchants[i], Pools.items.ward_el, 2)
	Distributor:requestItems(merchants[i], Pools.items.ward_1, 1)

	Distributor:requestItems(merchants[i], Pools.goods.t3.heal, 27, id)
	Distributor:requestItems(merchants[i], Pools.goods.t3.buff_1, 4, id)
	Distributor:requestItems(merchants[i], Pools.goods.t3.buff_2, 3, id)
	Distributor:requestItems(merchants[i], Pools.goods.t3.permo_ward_1, 2)
	Distributor:requestItems(merchants[i], Pools.goods.t3.permo_ward_2, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t3.permo_stat, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t3.artifact_1, 4)
	Distributor:requestItems(merchants[i], Pools.goods.t3.artifact_2, 3)
	Distributor:requestItems(merchants[i], Pools.goods.t3.relic_1, 3)
	Distributor:requestItems(merchants[i], Pools.goods.t3.boots, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t3.banner_1, 2)
	Distributor:requestItems(merchants[i], Pools.goods.t3.banner_2, 2)
	Distributor:requestItems(merchants[i], Pools.goods.t3.talisman_1, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t3.sphere_1, 2)
	Distributor:requestItems(merchants[i], Pools.goods.t3.sphere_2, 3)
	Distributor:requestItems(merchants[i], Pools.goods.t3.sphere_3, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t3.staff_1, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t3.staff_2, 1)
	Distributor:requestItems(merchants[i], Pools.goods.t2.scrolls_1, 2)
	Distributor:requestItems(merchants[i], Pools.goods.t2.scrolls_ward, 1)
	for id, config in pairs(setItemsConfig) do
		if not setItemsStatus[id] and config.shops and isTableContains(config.shops, 't3') then
			table.insert(merchants[#merchants].goods.items, { id = id, min = 1, max = 1 })
			setItemsStatus[id] = true
		end
	end
	i = i + 1

	return merchants
end

------------------------------------------------------------------------------------------------------------------------
--- Контент:Башня мага
------------------------------------------------------------------------------------------------------------------------
--- т1
function getMages1(race)
	local mages = {}
	local i = 1
	---
	mages[i] = absMage()
	Distributor:requestMageData(mages[i], Pools.objects.mages.t1)

	Distributor:requestSpells(mages[i], Pools.spells.t1.summons, 1, race)
	Distributor:requestSpells(mages[i], Pools.spells.t1.list, 14, race)
	if iad == 6 then
		Distributor:requestSpells(mages[i], Pools.spells.t1.iad, 1)
	end
	i = i + 1

	return mages
end

--- т3
function getMages3(id)
	local mages = {}
	local i = 1

	---
	mages[i] = absMage()
	Distributor:requestMageData(mages[i], Pools.objects.mages.t3)

	Distributor:requestSpells(mages[i], Pools.spells.t3.list, 4)
	Distributor:requestSpells(mages[i], Pools.spells.t3.wards, 1)
	Distributor:requestSpells(mages[i], Pools.spells.t3.antiwards, 1)
	Distributor:requestSpells(mages[i], Pools.spells.t3.summons, 1)
	Distributor:requestSpells(mages[i], Pools.spells.t3.special, 1)
	i = i + 1

	return mages
end
------------------------------------------------------------------------------------------------------------------------
--- Контент:Лагерь наемников
------------------------------------------------------------------------------------------------------------------------
--- т2
function getMercenaries2(race)
	local mercenaries = {}
	local i = 1

	---
	mercenaries[i] = absMercenary()
	Distributor:requestMercenaryData(mercenaries[i], Pools.objects.mercenaries.t2)

	Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t2.m1, 2, race)
	Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t2.m2, 6, race)
	Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t2.m3, 1, race)
	Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t2.m4, 1, race)
	i = i + 1

	return mercenaries
end

--- т3
function getMercenaries3(id)
	local mercenaries = {}
	local i = 1
	---
	mercenaries[i] = absMercenary()
	Distributor:requestMercenaryData(mercenaries[i], Pools.objects.mercenaries.t3)

	for _,race in ipairs(ALL_RACES) do
		Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t3.m6, 1, race)
		Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t3.m7, 1, race)
	end
	Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t3.m5, 2)
	Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t3.m4, 1)
	Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t3.m3, 1)
	Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t3.m2, 1)
	Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t3.m1, 1)
	i = i + 1

	return mercenaries
end

--- т5
function getMercenaries5()
	local mercenaries = {}
	local i = 1

	---
	mercenaries[i] = absMercenary()
	Distributor:requestMercenaryData(mercenaries[i], Pools.objects.mercenaries.t5)

	for _,race in ipairs(ALL_RACES) do
		Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t2.m4, 1, race)
		Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t2.m3, 1, race)
	end
	Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t5.m4, 1)
	Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t5.m3, 1)
	Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t5.m2, 1)
	Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t5.m1, 1)
	Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t3.m5, 2)
	Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t3.m4, 1)
	Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t3.m3, 1)
	Distributor:requestMercenaryUnits(mercenaries[i], Pools.mercenaries.t3.m2, 1)
	i = i + 1

	return mercenaries
end
------------------------------------------------------------------------------------------------------------------------
--- Контент:Тренер
------------------------------------------------------------------------------------------------------------------------
--- т3
function getTrainers3(id)
	local trainers = {}
	local i = 1

	---
	trainers[i] = absTrainer()
	Distributor:requestTrainerData(trainers[i], Pools.objects.trainers.t3)
	i = i + 1

	return trainers
end
------------------------------------------------------------------------------------------------------------------------
--- Контент:Рынок ресурсов
------------------------------------------------------------------------------------------------------------------------
--- т4
function getMarkets4()
	local markets = {}
	local i = 1

	---
	markets[i] = absMarket()
	Distributor:requestMarketData(markets[i], Pools.objects.markets.t4)
	markets[i].stock = {
		{ resource = Resource.Gold, value = { min = 1500, max = 1500 }},
		{ resource = Resource.LifeMana, value = { min = 500, max = 500 }},
		{ resource = Resource.DeathMana, value = { min = 500, max = 500 }},
		{ resource = Resource.InfernalMana, value = { min = 500, max = 500 }},
		{ resource = Resource.RunicMana, value = { min = 500, max = 500 }},
		{ resource = Resource.GroveMana, value = { min = 500, max = 500 }},
	}
	markets[i].exchangeRates = [[
		function getExchangeRates(visitor)
			local k1 = 15
			local k2 = 5
			if visitor.owner.lord == Lord.Mage then
				k1 = 10
			end
			return {
				{
					Resource.Gold,
					{
					{ Resource.LifeMana, k1, k2 },
					{ Resource.DeathMana, k1, k2 },
					{ Resource.RunicMana, k1, k2 },
					{ Resource.InfernalMana, k1, k2 },
					{ Resource.GroveMana, k1, k2 }
					}
				},
				{
					Resource.LifeMana,
					{
					{ Resource.Gold, k1, k2 },
					{ Resource.DeathMana, k1, k2 },
					{ Resource.RunicMana, k1, k2 },
					{ Resource.InfernalMana, k1, k2 },
					{ Resource.GroveMana, k1, k2 }
					}
				},
				{
					Resource.DeathMana,
					{
					{ Resource.LifeMana, k1, k2 },
					{ Resource.Gold, k1, k2 },
					{ Resource.RunicMana, k1, k2 },
					{ Resource.InfernalMana, k1, k2 },
					{ Resource.GroveMana, k1, k2 }
					}
				},
				{
					Resource.RunicMana,
					{
					{ Resource.LifeMana, k1, k2 },
					{ Resource.DeathMana, k1, k2 },
					{ Resource.Gold, k1, k2 },
					{ Resource.InfernalMana, k1, k2 },
					{ Resource.GroveMana, k1, k2 }
					}
				},
				{
					Resource.InfernalMana,
					{
					{ Resource.LifeMana, k1, k2 },
					{ Resource.DeathMana, k1, k2 },
					{ Resource.RunicMana, k1, k2 },
					{ Resource.Gold, k1, k2 },
					{ Resource.GroveMana, k1, k2 }
					}
				},
				{
					Resource.GroveMana,
					{
					{ Resource.LifeMana, k1, k2 },
					{ Resource.DeathMana, k1, k2 },
					{ Resource.RunicMana, k1, k2 },
					{ Resource.InfernalMana, k1, k2 },
					{ Resource.Gold, k1, k2 }
					}
				},
			}
		end
	]]
	i = i + 1

	return markets
end

--- тM
function getMarketsM()
	local markets = {}
	local i = 1

	---
	markets[i] = absMarket()
	Distributor:requestMarketData(markets[i], Pools.objects.markets.tm)
	markets[i].stock = {
		{ resource = Resource.Gold, value = { min = 322, max = 322 }},
		{ resource = Resource.LifeMana, value = { min = 0, max = 0 }},
		{ resource = Resource.DeathMana, value = { min = 0, max = 0 }},
		{ resource = Resource.InfernalMana, value = { min = 0, max = 0 }},
		{ resource = Resource.RunicMana, value = { min = 0, max = 0 }},
		{ resource = Resource.GroveMana, value = { min = 0, max = 0 }},
	}
	markets[i].exchangeRates = [[
		function getExchangeRates(visitor)
			local k1 = 1
			local k2 = 25
			if visitor.leader.impl.type == Unit.Summon then
				k1 = 0
				k2 = 0
			end
			return {
				{
					Resource.Gold,
					{
					{ Resource.LifeMana, k1, k2 },
					{ Resource.DeathMana, k1, k2 },
					{ Resource.RunicMana, k1, k2 },
					{ Resource.InfernalMana, k1, k2 },
					{ Resource.GroveMana, k1, k2 }
					}
				},
				{
					Resource.LifeMana,
					{
					{ Resource.Gold, k2, k1 },
					{ Resource.DeathMana, k2, k2 },
					{ Resource.RunicMana, k2, k2 },
					{ Resource.InfernalMana, k2, k2 },
					{ Resource.GroveMana, k2, k2 }
					}
				},
				{
					Resource.DeathMana,
					{
					{ Resource.LifeMana, k2, k2 },
					{ Resource.Gold, k2, k1 },
					{ Resource.RunicMana, k2, k2 },
					{ Resource.InfernalMana, k2, k2 },
					{ Resource.GroveMana, k2, k2 }
					}
				},
				{
					Resource.RunicMana,
					{
					{ Resource.LifeMana, k2, k2 },
					{ Resource.DeathMana, k2, k2 },
					{ Resource.Gold, k2, k1 },
					{ Resource.InfernalMana, k2, k2 },
					{ Resource.GroveMana, k2, k2 }
					}
				},
				{
					Resource.InfernalMana,
					{
					{ Resource.LifeMana, k2, k2 },
					{ Resource.DeathMana, k2, k2 },
					{ Resource.RunicMana, k2, k2 },
					{ Resource.Gold, k2, k1 },
					{ Resource.GroveMana, k2, k2 }
					}
				},
				{
					Resource.GroveMana,
					{
					{ Resource.LifeMana, k2, k2 },
					{ Resource.DeathMana, k2, k2 },
					{ Resource.RunicMana, k2, k2 },
					{ Resource.InfernalMana, k2, k2 },
					{ Resource.Gold, k2, k1 }
					}
				},
			}
		end
	]]
	i = i + 1

	return markets
end
------------------------------------------------------------------------------------------------------------------------
--- Контент:Рудники
------------------------------------------------------------------------------------------------------------------------
--- т0
function getMines0(race)
	local mines = absMines()
	Distributor:requestMines(mines, Pools.mines.gold.t0, 0)
	Distributor:requestMines(mines, Pools.mines.racial, 1, race)
	Distributor:requestMines(mines, Pools.mines.first, 1, race)
	Distributor:requestMines(mines, Pools.mines.second, 0, race)

	return mines
end

--- т1
function getMines1(race)
	local mines = absMines()
	Distributor:requestMines(mines, Pools.mines.gold.t1, 0)
	Distributor:requestMines(mines, Pools.mines.racial, 1, race)
	Distributor:requestMines(mines, Pools.mines.first, 1, race)
	Distributor:requestMines(mines, Pools.mines.second, 1, race)

	return mines
end

--- т2
function getMines2(race)
	local mines = absMines()
	Distributor:requestMines(mines, Pools.mines.gold.t2, 0)
	Distributor:requestMines(mines, Pools.mines.racial, 0, race)
	Distributor:requestMines(mines, Pools.mines.first, 0, race)
	Distributor:requestMines(mines, Pools.mines.second, 1, race)

	return mines
end

--- т3
function getMines3()
	local mines = absMines()
	Distributor:requestMines(mines, Pools.mines.gold.t3, 1)
	Distributor:requestMines(mines, Pools.mines.t3, 1)
	return mines
end

--- т4
function getMines4()
	local mines = absMines()
	Distributor:requestMines(mines, Pools.mines.gold.t4, 0)
	for _,race in pairs(getMissingRaces()) do
		Distributor:requestMines(mines, Pools.mines.racial, 1, race)
	end
	return mines
end

--- т5
function getMines5()
	local mines = absMines()
	Distributor:requestMines(mines, Pools.mines.gold.t5, 1)
	for _,race in pairs(Races) do
		Distributor:requestMines(mines, Pools.mines.racial, 1, race)
	end
	return mines
end

------------------------------------------------------------------------------------------------------------------------
--- Контент:Сундуки
------------------------------------------------------------------------------------------------------------------------
--- т0
function getBags0(race)
	local bags = absBags()
	Distributor:requestItems(bags, Pools.items.bags.t0.heal_1, 1, race)
	Distributor:requestItems(bags, Pools.items.bags.t0.heal_2, 2, race)
	Distributor:requestItems(bags, Pools.items.ward_dot, 1)
	return bags
end

--- т1
function getBags1(race)
	local bags = absBags()
	Distributor:requestItems(bags, Pools.items.bags.t1.heal_1, 1, race)
	Distributor:requestItems(bags, Pools.items.bags.t1.heal_2, 2, race)
	Distributor:requestItems(bags, Pools.items.buff_e1, 1)
	return bags
end

--- т2
function getBags2(race)
	local bags = absBags()
	Distributor:requestItems(bags, Pools.items.bags.t2.heal_1, 1, race)
	Distributor:requestItems(bags, Pools.items.bags.t2.heal_2, 2, race)
	Distributor:requestItems(bags, Pools.items.bags.t2.gold, 1, race)
	Distributor:requestItems(bags, Pools.items.buff_e2, 1)
	return bags
end

--- т3
function getBags3(race)
	local bags = absBags()
	Distributor:requestItems(bags, Pools.items.bags.t3.heal_1, 3, race)
	Distributor:requestItems(bags, Pools.items.bags.t3.gold, 1, race)
	Distributor:requestItems(bags, rnd(
			Pools.items.buff_1,
			Pools.items.ward_el
	), 1)
	return bags
end

--- т5
function getBags5(race)
	local bags = absBags()
	bags.count = 2
	Distributor:requestItems(bags, Pools.items.bags.t5.heal_1, 2, race)
	Distributor:requestItems(bags, Pools.items.bags.t5.gold, 1, race)
	Distributor:requestItems(bags, Pools.items.bags.t5.permo_1, 1)
	Distributor:requestItems(bags, Pools.items.bags.t5.permo_2, 1)
	Distributor:requestItems(bags, Pools.items.buff_e2, 1)
	return bags
end

------------------------------------------------------------------------------------------------------------------------
--- Зоны
------------------------------------------------------------------------------------------------------------------------
--- Зона:т0
function getZone0(id, race)
	local zone = absZone(id, getZoneSizes().z0)
	zone.label = 0
	zone.type = Zone.PlayerStart
	zone.race = race
	zone.capital = getCapital0(race)
	zone.mines = getMines0(race)
	zone.bags = getBags0(race)
	zone.stacks = getStacks0(race)
	zone.ruins = getRuins0(race)
	return zone
end
------------------------------------------------------------------------------------------------------------------------
--- Зона:т1
function getZone1(id, race)
	local zone = absZone(id, getZoneSizes().z1)
	zone.label = 1
	zone.towns = getTowns1(race)
	zone.mines = getMines1(race)
	zone.bags = getBags1(race)
	zone.stacks = getStacks1(race)
	zone.ruins = getRuins1(race)
	zone.merchants = getMerchants1(race)
	zone.mages = getMages1(race)
	return zone
end
------------------------------------------------------------------------------------------------------------------------
--- Зона:т2
function getZone2(id, race)
	local zone = absZone(id, getZoneSizes().z2)
	zone.label = 2
	zone.towns = getTowns2(race)
	zone.mines = getMines2(race)
	zone.bags = getBags2(race)
	zone.stacks = getStacks2(race)
	zone.ruins = getRuins2(race)
	zone.merchants = getMerchants2(race)
	zone.mercenaries = getMercenaries2(race)
	return zone
end
------------------------------------------------------------------------------------------------------------------------
--- Зона:т3
local ZONE3_A_OBJECTS = {}
local ZONE3_B_OBJECTS = {}
local ZONE3_A_RUINS = {}
local ZONE3_B_RUINS = {}
local BORDERS_1 = {Border.Open, Border.Water, Border.SemiOpen}
local BORDERS_2 = {Border.Open, Border.Water, Border.SemiOpen}

function initZone3()
	local object_amount = {2, 2}
	local buildings = {"merchant", "mage", "trainer"}
	local ruins = {"r1", "r2", "r3", "r4"}
	local ruins_amount = {2, 2}

	if template_mode == trinity and treasure_mode then
		object_amount = {2, 1}
		shake(object_amount)
		ruins_amount = {object_amount[2], object_amount[1]}
	elseif template_mode == trinity and not treasure_mode then
		object_amount = {2, 2}
		shake(object_amount)
		ruins_amount = {1, 1}
		table.insert(buildings, "mercenary")
	else
		table.insert(buildings, "mercenary")
	end

	if template_mode == trinity then
		table.remove(BORDERS_1, 3)
		table.remove(BORDERS_2, 3)
	end

	shake(object_amount)
	shake(buildings)
	shake(ruins)
	shake(BORDERS_1)
	shake(BORDERS_2)

	local count = 0
	local obj_var = ZONE3_A_OBJECTS
	for _,amount in ipairs(object_amount) do
		for i = 1, amount do
			count = count + 1
			table.insert(obj_var, buildings[count])
		end
		obj_var = ZONE3_B_OBJECTS
	end

	count = 0
	local ruin_var = ZONE3_A_RUINS
	for _,amount in ipairs(ruins_amount) do
		for i = 1, amount do
			count = count + 1
			table.insert(ruin_var, ruins[count])
		end
		ruin_var = ZONE3_B_RUINS
	end
end

function getBorderType(id)
	if border_mode == 1 then -- случайные(разные)
		shake(BORDERS_1)
		return BORDERS_1[1]
	elseif border_mode == 2 then -- случайные(одинаковые)
		return BORDERS_1[1]
	elseif border_mode == 3 then -- случайные(зеркальные)
		if id == c3_1 or id == c3_3 or id == c3_5 then
			return BORDERS_1[1]
		else
			return BORDERS_2[1]
		end
	elseif border_mode == 4 then -- открытые
		return Border.Open
	elseif border_mode == 5 then -- водные
		return Border.Water
	elseif border_mode == 6 then -- полуоткрытые
		return Border.SemiOpen
	end
end

function getZone3(id)
	if next(ZONE3_A_OBJECTS) == nil then
		initZone3()
	end

	local isZoneA = (id == c3_1 or id == c3_3 or id == c3_5)
	local zone_buildings = isZoneA and ZONE3_A_OBJECTS or ZONE3_B_OBJECTS
	local zone_ruins = isZoneA and ZONE3_A_RUINS or ZONE3_B_RUINS

	local zone = absZone(id, getZoneSizes().z3)
	zone.label = 3
	zone.type = Zone.Treasure
	zone.border = getBorderType(id)
	zone.mines = getMines3()
	zone.bags = getBags3(id)
	zone.stacks = getStacks3(id)
	zone.ruins = getRuins3(zone_ruins)
	for _, btype in ipairs(zone_buildings) do
		if btype == "merchant" then zone.merchants = getMerchants3(id) end
		if btype == "mage" then zone.mages = getMages3(id) end
		if btype == "mercenary" then zone.mercenaries = getMercenaries3(id) end
		if btype == "trainer" then zone.trainers = getTrainers3(id) end
	end
	return zone
end

------------------------------------------------------------------------------------------------------------------------
--- Зона:т4
function getZone4(id)
	local zone = absZone(id, getZoneSizes().z4)
	zone.label = 4
	zone.type = Zone.Treasure
	zone.border = Border.Open
	zone.towns = getTowns4()
	--zone.mines = getMines4()
	zone.stacks = getStacks4(id)
	zone.ruins = getRuins4()
	zone.resourceMarkets = getMarkets4()
	return zone
end

------------------------------------------------------------------------------------------------------------------------
--- Зона:т5
function getZone5(id)
	local zone = absZone(id, getZoneSizes().z5)
	zone.label = 5
	zone.border = tmd(Border.Close, Border.Open, Border.Close)
	zone.mines = getMines5()
	zone.bags = getBags5(id)
	zone.stacks = getStacks5(id)
	zone.ruins = getRuins5()
	if template_mode == trinity and treasure_mode then
		zone.mercenaries = getMercenaries5()
	end
	return zone
end

------------------------------------------------------------------------------------------------------------------------
--- Зона:Рынок
function getZoneM(id, race1, race2)
	local zone = absZone(id, getZoneSizes().zm)
	zone.label = 'M'
	zone.resourceMarkets = getMarketsM()
	zone.stacks = getStacksM(race1, race2)
	return zone
end

------------------------------------------------------------------------------------------------------------------------
--- Зона:Вода
function getZoneW(id)
	local zone = absZone(id, getZoneSizes().z5)
	zone.label = 'W'
	zone.type = Zone.Water
	zone.border = Border.Open
	zone.stacks = getStacksW(id)
	zone.bags = getBags5(id)
	return zone
end

------------------------------------------------------------------------------------------------------------------------
--- Зона:Пусто
function getZoneE(id)
	local zone = absZone(id, getZoneSizes().ze)
	zone.label = ''
	zone.type = Zone.Water
	return zone
end

------------------------------------------------------------------------------------------------------------------------
--- Зоны:Сводная
------------------------------------------------------------------------------------------------------------------------
function getZones()
	local zones = {}

	--- Зоны:Игрок 1
	shake(ruinsLootTypes)
	table.insert(zones, getZone0(c0_1, Races[1]))
	table.insert(zones, getZone1(c1_1, Races[1]))
	table.insert(zones, getZone2(c2_1, Races[1]))

	--- Зоны:Игрок 2
	shake(ruinsLootTypes)
	table.insert(zones, getZone0(c0_2, Races[2]))
	table.insert(zones, getZone1(c1_2, Races[2]))
	table.insert(zones, getZone2(c2_2, Races[2]))

	--- Зоны:Игрок 3
	if template_mode == trinity or template_mode == clover then
		shake(ruinsLootTypes)
		table.insert(zones, getZone0(c0_3, Races[3]))
		table.insert(zones, getZone1(c1_3, Races[3]))
		table.insert(zones, getZone2(c2_3, Races[3]))
	end

	--- Зоны:Игрок 4
	if template_mode == clover then
		shake(ruinsLootTypes)
		table.insert(zones, getZone0(c0_4, Races[4]))
		table.insert(zones, getZone1(c1_4, Races[4]))
		table.insert(zones, getZone2(c2_4, Races[4]))
	end

	--- Зоны:Лепестки
	table.insert(zones, getZone3(c3_1))
	table.insert(zones, getZone3(c3_2))
	table.insert(zones, getZone3(c3_3))
	table.insert(zones, getZone3(c3_4))
	if template_mode == trinity then
		table.insert(zones, getZone3(c3_5))
		table.insert(zones, getZone3(c3_6))
	end

	--- Зоны:Центр
	table.insert(zones, getZone4(c4_1))

	--- Зоны:Сокровищницы
	if treasure_mode then
		if template_mode == duo then
			table.insert(zones, getZone5(c5_1))
			table.insert(zones, getZone5(c5_2))
		elseif template_mode == trinity then
			table.insert(zones, getZone5(c5_1))
			table.insert(zones, getZone5(c5_3))
			if game_mode == 1 then
				table.insert(zones, getZone5(c5_2))
			end
		end
	end

	--- Зоны:Рынок
	if market_mode then
		if template_mode == trinity then
			table.insert(zones, getZoneM(cm_2, Races[2], Races[3]))
		elseif template_mode == clover then
			table.insert(zones, getZoneM(cm_1, Races[1], Races[2]))
			table.insert(zones, getZoneM(cm_2, Races[3], Races[4]))
		end
	end

	--- Зоны:Вода/Пусто
	if template_mode == duo then
		table.insert(zones, getZoneE(ce_1))
		table.insert(zones, getZoneE(ce_2))
		table.insert(zones, getZoneE(ce_3))
		table.insert(zones, getZoneE(ce_4))
		if not treasure_mode then
			table.insert(zones, getZoneW(cw_1))
			table.insert(zones, getZoneW(cw_2))
		end
	elseif template_mode == trinity then
		if not treasure_mode then
			table.insert(zones, getZoneW(cw_1))
			table.insert(zones, getZoneW(cw_3))
			if game_mode == 1 then
				table.insert(zones, getZoneW(cw_2))
			elseif not market_mode then
				table.insert(zones, getZoneE(ce_2))
			end
		else
			if game_mode ~= 1 and not market_mode then
				table.insert(zones, getZoneE(ce_2))
			end
		end
	end

	return zones
end

------------------------------------------------------------------------------------------------------------------------
--- Зоны:Размеры
------------------------------------------------------------------------------------------------------------------------
function getZoneSizes()
	local sizes = {
		z0 = 20,
		z1 = 20,
		z2 = 20,
		z3 = 16,
		z4 = 16,
		z5 = 20,
		ze = 18,
		zm = 10,
	}
	if template_mode == duo then

	elseif template_mode == trinity then
		sizes.z0 = 18
		sizes.z1 = 20
		sizes.z2 = 20
		sizes.z3 = 14
		sizes.z4 = 16
		sizes.z5 = 14
		sizes.ze = sizes.z5
		sizes.zm = sizes.z5

	elseif template_mode == clover then
		sizes.z0 = 18
		sizes.z3 = 18
		sizes.zm = 6
	end
	return sizes
end

------------------------------------------------------------------------------------------------------------------------
--- Соединения зон
------------------------------------------------------------------------------------------------------------------------
function getConnections_duo()
	local p01 = 6
	local p12 = 5
	local p23 = 3
	local p34 = 3
	local p35 = 3
	local p03 = 2
	local p05 = 1
	local pee = 5
	local pe2 = 5
	local pe5 = 5
	local p33 = 1
	local p24 = 1
	local p45 = 1

	local zones0 = {c0_1, c0_2}
	local zones1 = {c1_1, c1_2}
	local zones2 = {c2_1, c2_2}
	local zones3 = {c3_1, c3_2, c3_3, c3_4}
	local zones4 = {c4_1}
	local zonesE = {ce_1, ce_2, ce_3, ce_4}

	local zones5
	if treasure_mode then
		zones5 = {c5_1, c5_2}
	else
		zones5 = {cw_1, cw_2}
	end

	local connections = {}

	-- т0 -> т1
	for id = 1, p01 do
		addConn(connections, c0_1, c1_1, 1, getGuard01(Races[1], id))
		addConn(connections, c0_2, c1_2, 1, getGuard01(Races[2], id))
	end
	-- т1 -> т2
	addPairwise(connections, zones1, zones2, 1, nil, p12)
	-- т2 -> т3
	local pairs23 = {
		{c2_1, {c3_1, c3_2}},
		{c2_2, {c3_3, c3_4}},
	}
	for _ = 1, p23 do
		for _, pair in ipairs(pairs23) do
			for _, toZone in ipairs(pair[2]) do
				addConn(connections, pair[1], toZone, 1, nil)
			end
		end
	end
	-- т3 -> т4
	for id = 1, p34 do
		for _, toZone in ipairs(zones3) do
			addConn(connections, c4_1, toZone, 1, getGuard34(toZone, id))
		end
	end
	-- т3 -> т5
	local pairs35 = {
		{c3_1, zones5[1]}, {c3_4, zones5[1]},
		{c3_2, zones5[2]}, {c3_3, zones5[2]},
	}
	for _ = 1, p35 do
		for _, pair in ipairs(pairs35) do
			addConn(connections, pair[1], pair[2], 1, nil)
		end
	end
	-- т0 -> т3
	local pairs03 = {
		{c0_1, c3_1},
		{c0_2, c3_3},
	}
	for _ = 1, p03 do
		for _, pair in ipairs(pairs03) do
			addConn(connections, pair[1], pair[2], 1, nil)
		end
	end
	-- т0 -> т5
	local pairs05 = {
		{c0_1, zones5[1]},
		{c0_2, zones5[2]},
	}
	for _ = 1, p05 do
		for _, pair in ipairs(pairs05) do
			addConn(connections, pair[1], pair[2], 0, nil)
		end
	end
	-- тE -> тE
	local pairsEE = {
		{ce_1, ce_2},
		{ce_3, ce_4},
	}
	for _ = 1, pee do
		for _, pair in ipairs(pairsEE) do
			addConn(connections, pair[1], pair[2], 0, nil)
		end
	end
	-- тE -> т2
	local pairsE2 = {
		{ce_1, c2_1},
		{ce_3, c2_2},
	}
	for _ = 1, pe2 do
		for _, pair in ipairs(pairsE2) do
			addConn(connections, pair[1], pair[2], 0, nil)
		end
	end
	-- тE -> т5
	local pairsE5 = {
		{ce_2, zones5[2]},
		{ce_4, zones5[1]},
	}
	for _ = 1, pe5 do
		for _, pair in ipairs(pairsE5) do
			addConn(connections, pair[1], pair[2], 0, nil)
		end
	end
	--- т3 -> т3
	for _ = 1, p33 do
		for i = 1, #zones3 do
			local next = i % #zones3 + 1
			addConn(connections, zones3[i], zones3[next], 0, nil, false)
		end
	end
	-- т2 -> т4
	addCartesian(connections, zones2, zones4, 0, nil, p24, false)
	-- т4 -> т5
	addCartesian(connections, zones4, zones5, 0, nil, p45)

	return connections
end

------------------------------------------------------------------------------------------------------------------------
function getConnections_trinity()
	local p01 = 6
	local p12 = 5
	local p23 = 3
	local p25 = 1
	local p34 = 3
	local p35 = 3
	local p03 = 2
	local p05 = 1
	local p13 = 1
	local p33 = 1

	local zones0 = {c0_1, c0_2, c0_3}
	local zones1 = {c1_1, c1_2, c1_3}
	local zones2 = {c2_1, c2_2, c2_3}
	local zones3 = {c3_1, c3_2, c3_3, c3_4, c3_5, c3_6}
	local zones4 = {c4_1}

	-- Определяем целевые зоны (слоты A, B, C)
	local targetA, targetB, targetC
	if game_mode == 1 then
		if treasure_mode then
			targetA, targetB, targetC = c5_1, c5_2, c5_3
		else
			targetA, targetB, targetC = cw_1, cw_2, cw_3
		end
	else
		targetA = treasure_mode and c5_1 or cw_1
		targetC = treasure_mode and c5_3 or cw_3
		if market_mode then
			targetB = cm_2
		else
			targetB = ce_2
		end
	end

	local connections = {}

	-- т0 -> т1
	for id = 1, p01 do
		addConn(connections, c0_1, c1_1, 1, getGuard01(Races[1], id))
		addConn(connections, c0_2, c1_2, 1, getGuard01(Races[2], id))
		addConn(connections, c0_3, c1_3, 1, getGuard01(Races[3], id))
	end
	-- т1 -> т2
	addPairwise(connections, zones1, zones2, 1, nil, p12)

	-- т2 -> т3
	local pairs23 = {
		{c2_1, {c3_1, c3_2}},
		{c2_2, {c3_3, c3_4}},
	}
	if game_mode == 1 then
		table.insert(pairs23, {c2_3, {c3_5, c3_6}})
	else
		table.insert(pairs23, {c2_3, {c3_5, c3_4}})
	end
	for _ = 1, p23 do
		for _, pair in ipairs(pairs23) do
			for _, toZone in ipairs(pair[2]) do
				addConn(connections, pair[1], toZone, 1, nil)
			end
		end
	end

	-- т2 -> целевые зоны (p25)
	for _ = 1, p25 do
		addConn(connections, c2_1, targetA, 0, nil)
		addConn(connections, c2_2, targetB, 0, nil)
		addConn(connections, c2_3, targetC, 0, nil)
	end

	-- т3 -> т4
	for id = 1, p34 do
		for _, toZone in ipairs(zones3) do
			addConn(connections, c4_1, toZone, 1, getGuard34(toZone, id))
		end
	end

	-- т3 -> целевые зоны (только если treasure_mode активен)
	if treasure_mode then
		for _ = 1, p35 do
			addConn(connections, c3_2, targetA, 1, nil)
			if game_mode == 1 then
				addConn(connections, c3_4, targetB, 1, nil)
			else
				addConn(connections, c3_4, targetB, 0, nil)
			end
			addConn(connections, c3_6, targetC, 1, nil)
		end
	end

	-- т0 -> т3
	for _ = 1, p03 do
		addConn(connections, c0_1, c3_6, 0, nil)
		addConn(connections, c0_1, c3_1, 1, nil)
		addConn(connections, c0_2, c3_2, 0, nil)
		addConn(connections, c0_2, c3_3, 1, nil)
		if game_mode == 1 then
			addConn(connections, c0_3, c3_4, 0, nil)
			addConn(connections, c0_3, c3_5, 1, nil)
		else
			addConn(connections, c0_3, c3_6, 0, nil)
			addConn(connections, c0_3, c3_5, 1, nil)
		end
	end

	-- т0 -> целевые зоны (p05)
	for _ = 1, p05 do
		addConn(connections, c0_1, targetC, 0, nil)
		addConn(connections, c0_2, targetA, 0, nil)
		if game_mode == 1 then
			addConn(connections, c0_3, targetB, 0, nil)
		else
			addConn(connections, c0_3, targetB, 0, nil)
		end
	end

	-- т1 -> т3
	for _ = 1, p13 do
		addConn(connections, c3_1, c1_1, 0, nil)
		addConn(connections, c3_3, c1_2, 0, nil)
		addConn(connections, c3_5, c1_3, 0, nil)
	end

	-- т3 -> т3 (кольцо)
	for _ = 1, p33 do
		for i = 1, #zones3 do
			local next = i % #zones3 + 1
			addConn(connections, zones3[i], zones3[next], 0, nil, false)
		end
	end

	return connections
end

------------------------------------------------------------------------------------------------------------------------
function getConnections_clover()
	local p01 = 6
	local p12 = 5
	local p23 = 3
	local p34 = 3
	local p03 = 2
	local p24 = 1
	local p33 = 1
	local p00 = 0
	local p22 = 0

	local zones0 = {c0_1, c0_2, c0_3, c0_4}
	local zones1 = {c1_1, c1_2, c1_3, c1_4}
	local zones2 = {c2_1, c2_2, c2_3, c2_4}
	local zones3 = {c3_1, c3_2, c3_3, c3_4}
	local zones4 = {c4_1}

	local connM1 = {}
	local connM2 = {}

	local connections = {}

	-- т0 -> т1
	for id = 1, p01 do
		addConn(connections, c0_1, c1_1, 1, getGuard01(Races[1], id))
		addConn(connections, c0_2, c1_2, 1, getGuard01(Races[2], id))
		addConn(connections, c0_3, c1_3, 1, getGuard01(Races[3], id))
		addConn(connections, c0_4, c1_4, 1, getGuard01(Races[4], id))
	end
	-- т1 -> т2
	addPairwise(connections, zones1, zones2, 1, nil, p12)
	-- т3 -> т4
	for id = 1, p34 do
		for _, toZone in ipairs(zones3) do
			addConn(connections, c4_1, toZone, 1, getGuard34(toZone, id))
		end
	end
	-- т0 -> т3
	addPairwise(connections, zones0, zones3, 1, nil, p03)

	if game_mode == 1 then

		local pairs23 = {
			{c2_1, {c3_4, c3_1}},
			{c2_2, {c3_1, c3_2}},
			{c2_3, {c3_2, c3_3}},
			{c2_4, {c3_3, c3_4}},
		}
		for _ = 1, p23 do
			for _, pair in ipairs(pairs23) do
				local fromZone = pair[1]
				for _, toZone in ipairs(pair[2]) do
					addConn(connections, fromZone, toZone, 1, nil)
				end
			end
		end

		for _ = 1, p33 do
			for i = 1, #zones3 do
				local next = i % #zones3 + 1
				addConn(connections, zones3[i], zones3[next], 0, nil, false)
			end
		end

		addCartesian(connections, zones2, zones4, 0, nil, p24, false)

	elseif game_mode == 2 or game_mode == 3 then
		-- т0 -> т0
		p00 = 5
		p22 = 1
		p33 = 0
		for _ = 1, p00 do
			addConn(connections, c0_1, c0_2, 1, nil)
			addConn(connections, c0_3, c0_4, 1, nil)
		end
		-- т2 -> т2
		for _ = 1, p22 do
			addConn(connections, c2_1, c2_4, 0, nil)
			addConn(connections, c2_2, c2_3, 0, nil)
		end
		-- Обычные связи т2 -> т3 (каждый к своему лепестку)
		addPairwise(connections, zones2, zones3, 1, nil, p23)

		if market_mode then
			connM1 = {c0_1, c0_2, c3_1, c3_2}
			connM2 = {c0_3, c0_4, c3_3, c3_4}
		end

	elseif game_mode == 4 or game_mode == 5 then
		p00 = 1
		p22 = 5
		p33 = 0
		-- т0 -> т0
		for _ = 1, p00 do
			addConn(connections, c0_1, c0_4, 0, nil)
			addConn(connections, c0_2, c0_3, 0, nil)
		end
		-- Связи между т2 зонами
		for _ = 1, p22 do
			addConn(connections, c2_1, c2_2, 1, nil)
			addConn(connections, c2_3, c2_4, 1, nil)
		end
		addPairwise(connections, zones2, zones3, 1, nil, p23)

		if market_mode then
			connM1 = {c0_4, c0_1, c3_4, c3_1}
			connM2 = {c0_2, c0_3, c3_2, c3_3}
		end
	end

	if market_mode then
		for _, fromZone in ipairs(connM1) do
			addConn(connections, fromZone, cm_1, 0, nil, false)
		end
		for _, fromZone in ipairs(connM2) do
			addConn(connections, fromZone, cm_2, 0, nil, false)
		end
	end

	return connections
end

------------------------------------------------------------------------------------------------------------------------
function getConnections()
	return tmd(
			getConnections_duo(),
			getConnections_trinity(),
			getConnections_clover()
	)
end

------------------------------------------------------------------------------------------------------------------------
--- Переменные сценария
------------------------------------------------------------------------------------------------------------------------
function getScenarioVariables()
	local result = {}

	if emd({false, false, true, true}) then
		table.insert(result, { name = 'HIRE_UNIT_ANY_RACE', value = 1 })
	end

	local lords = { 'WARRIOR', 'MAGE', 'GUILDMASTER' }
	local l_vars = {
		{ name = '_GOLD_INCOME', value = {0, 0, 25} },
		{ name = '_MANA_INCOME', value = {0, 25, 0} },
	}

	for i, lord in pairs(lords) do
		for _, v in pairs(l_vars) do
			table.insert(result, { name = lord..v['name'], value = v['value'][i] })
		end
	end

	local races = { 'EMPIRE', 'LEGIONS', 'CLANS', 'HORDES', 'ELVES' }
	local t0 = 50
	local t1 = 50
	local t2 = 50
	local t3 = 100
	local t4 = 175
	local t5 = 250
	local r_vars = emd({
		-- оригинал
		{
			{ name = '_TIER_0_CITY_INCOME', value = t0 },
			{ name = '_TIER_1_CITY_INCOME', value = t1 },
			{ name = '_TIER_2_CITY_INCOME', value = t2 },
			{ name = '_TIER_3_CITY_INCOME', value = t3 },
			{ name = '_TIER_4_CITY_INCOME', value = t4 },
			{ name = '_TIER_5_CITY_INCOME', value = t5 },
		},
		-- бесит!
		{
			{ name = '_SCOUT_FLAT', value = 99 },
			{ name = '_TIER_0_CITY_INCOME', value = t0 },
			{ name = '_TIER_1_CITY_INCOME', value = t1 },
			{ name = '_TIER_2_CITY_INCOME', value = t2 },
			{ name = '_TIER_3_CITY_INCOME', value = t3 },
			{ name = '_TIER_4_CITY_INCOME', value = t4 },
			{ name = '_TIER_5_CITY_INCOME', value = t5 },
		},
		-- котобесия
		{
			{ name = '_SCOUT_FLAT', value = 99 },
			{ name = '_TIER_0_CITY_INCOME', value = t0 - t0 },
			{ name = '_TIER_1_CITY_INCOME', value = t1 - t0 },
			{ name = '_TIER_2_CITY_INCOME', value = t2 - t0 },
			{ name = '_TIER_3_CITY_INCOME', value = t3 - t0 },
			{ name = '_TIER_4_CITY_INCOME', value = t4 - t0 },
			{ name = '_TIER_5_CITY_INCOME', value = t5 - t0 },
		},
		-- котовасия
		{
			{ name = '_TIER_0_CITY_INCOME', value = t0 - t0 },
			{ name = '_TIER_1_CITY_INCOME', value = t1 - t0 },
			{ name = '_TIER_2_CITY_INCOME', value = t2 - t0 },
			{ name = '_TIER_3_CITY_INCOME', value = t3 - t0 },
			{ name = '_TIER_4_CITY_INCOME', value = t4 - t0 },
			{ name = '_TIER_5_CITY_INCOME', value = t5 - t0 },
		}
	})
	for _, v in pairs(r_vars) do
		for _, race in pairs(races) do
			table.insert(result, { name = race..v['name'], value = v['value'] })
		end
	end
	return result
end
------------------------------------------------------------------------------------------------------------------------
--- Кастомные параметры
------------------------------------------------------------------------------------------------------------------------
function getCustomParameters()
	local params = {}

	--- Режим
	local mode = {
		name = 'Режим',
		values = {},
		default = game_mode
	}

	if template_mode == duo then
		mode.values = {
			'1x1',
		}
	elseif template_mode == trinity then
		mode.values = {
			'1x1x1',
			'1x2 [рынок]',
			'1x2',
		}
	elseif template_mode == clover then
		mode.values = {
			'1x1x1x1',
			'2x2 [т0][рынок]',
			'2x2 [т0]',
			'2x2 [т2][рынок]',
			'2x2 [т2]',
		}
	end

	--- Событие
	local event = {
		name = 'Событие',
		values = {
			'Нет',
			'Бесит!',
			'КотоБесия',
			'Котовасия',
		},
		default = event_mode
	}

	---
	local treasure = {
		name = 'Сокровищницы',
		values = {
			'Нет'
		},
		default = 1,
	}
	if template_mode == duo or template_mode == trinity then
		treasure.values = {
			'Нет',
			'Да',
		}
		treasure.default = 2
	end

	--- Границы
	local borders = {
		name = 'Границы',
		values = {
			'Случайные',
			'Одинаковые',
			'Зеркально',
			'Открытые',
			'Водные',
			'Полуоткрытые',
		},
		default = border_mode
	}

	--- Нейтралы
	local neutrals = {
		name = 'Нейтралы',
		min = 50,
		max = 200,
		step = 5,
		default = 100,
		unit = '%'
	}

	table.insert(params, mode)
	table.insert(params, event)
	table.insert(params, treasure)
	table.insert(params, borders)
	table.insert(params, neutrals)

	return params
end

function readCustomParameters(parameters)
	if parameters then
		if parameters[1] then
			game_mode = parameters[1]
			if game_mode > 1 and game_mode % 2 == 0 then
				market_mode = true
			end
		end
		if parameters[2] then
			event_mode = parameters[2]
		end
		if parameters[3] and parameters[3] == 2 then
			treasure_mode = true
		end
		if parameters[4] then
			border_mode = parameters[4]
		end
		if parameters[5] then
			kef = parameters[5] / 100
		end
	end
end
------------------------------------------------------------------------------------------------------------------------
--- Дипломатия
------------------------------------------------------------------------------------------------------------------------
function getDiplomacyRelations()
	if template_mode == trinity then
		if game_mode > 1 then
			--- игрок 2
			c0_2 = 209 -- оранжевый
			c1_2 = 210 -- т.зелёный
			c2_2 = 211 -- т.синий
			--- игрок 3
			c0_3 = 309 -- оранжевый
			c1_3 = 310 -- т.зелёный
			c2_3 = 311 -- т.синий
			return
			{
				{
					raceA = Races[2],
					raceB = Races[3],
					relation = 100,
					alliance = true,
					permanentAlliance = true,
				},
				{
					raceA = Races[1],
					raceB = Races[2],
					relation = 0,
					alwaysAtWar  = true,
				},
				{
					raceA = Races[1],
					raceB = Races[3],
					relation = 0,
					alwaysAtWar  = true,
				}
			}
		else
			return{}
		end
	elseif template_mode == clover then
		if game_mode > 1 then
			--- игрок 3
			c0_3 = 309 -- оранжевый
			c1_3 = 310 -- т.зелёный
			c2_3 = 311 -- т.синий
			--- игрок 4
			c0_4 = 409 -- оранжевый
			c1_4 = 410 -- т.зелёный
			c2_4 = 411 -- т.синий
			return {
				{
					raceA = Races[1],
					raceB = Races[2],
					relation = 100,
					alliance = true,
					permanentAlliance = true,
				},
				{
					raceA = Races[3],
					raceB = Races[4],
					relation = 100,
					alliance = true,
					permanentAlliance = true,
				},
				{
					raceA = Races[1],
					raceB = Races[3],
					relation = 0,
					alwaysAtWar  = true,
				},
				{
					raceA = Races[1],
					raceB = Races[4],
					relation = 0,
					alwaysAtWar  = true,
				},
				{
					raceA = Races[2],
					raceB = Races[3],
					relation = 0,
					alwaysAtWar  = true,
				},
				{
					raceA = Races[2],
					raceB = Races[4],
					relation = 0,
					alwaysAtWar  = true,
				},
			}
		else
			return {}
		end
	else
		return {}
	end
end
------------------------------------------------------------------------------------------------------------------------
--- Расы
------------------------------------------------------------------------------------------------------------------------
function shuffleRaces(races)
	if template_mode == trinity and game_mode ~= 1 then
		local team1 = {races[1], races[2]}
		local team2 = {races[3], races[4]}
		shake(team1)
		shake(team2)
		local teams = {team1, team2}
		shake(teams)
		races = {
			teams[1][1], teams[1][2],
			teams[2][1], teams[2][2],
		}
	elseif template_mode == clover and game_mode ~= 1 then
		local team = {races[2], races[3]}
		shake(team)
		races = {races[1], team[1], team[2]}
	else
		shake(races)
	end
	Races = races
end
------------------------------------------------------------------------------------------------------------------------
--- Шаблон
------------------------------------------------------------------------------------------------------------------------
function getTemplateContents(races, size, parameters)
	local contents = {}

	shuffleRaces(races)
	readCustomParameters(parameters)

	-- Инициализируем систему распределения
	Distributor:init()

	contents.diplomacy = getDiplomacyRelations()
	contents.zones = getZones()
	contents.connections = getConnections()
	contents.scenarioVariables = getScenarioVariables()

	-- Выполняем распределение данных
	Distributor:distribute()

	return contents
end
---
template = {
	name = 'Bladerunner['..tmd('Duo', 'Trinity', 'Clover')..'] '..version,
	description = 'Шаблон для игры 1x1. 1 герой, 1 жезловик, 1 вор\nСиняя, т.синяя, оранжевая, желтая зоны должны касаться двух т.серых зон центра\nАвтор оригинального шаблона Uchenik. Спасибо за поддержку! Карта Тинькофф: 2200700846776804',
	minSize = tmd(72, 72, 72),
	maxSize = tmd(96, 96, 96),
	maxPlayers = tmd(2, 3, 4),
	startingGold = 800,
	startingNativeMana = 150,
	roads = 35,
	forest = 20,
	iterations = tmd(10000, 50000, 100000),

	customParameters = getCustomParameters(),

	forbiddenUnits = {
		-- Стандартные
		--- Фракционные герои-лидеры и их вторые формы
		'g000uu0021', --Архимаг
		'g000uu8248', --Архимаг
		'g000uu0020', --Следопыт
		'g000uu0019', --Рыцарь на Пегасе
		'g000uu0022', --Архангел
		'g000uu0023', --Вор
		'g000uu5300', --Вор
		'g000uu0044', --Королевский страж
		'g000uu0045', --Инженер
		'g000uu0046', --Ученый
		'g000uu8249', --Ученый
		'g000uu0047', --Старейшина
		'g000uu0048', --Вор
		'g000uu5301', --Вор
		'g000uu0070', --Герцог
		'g000uu0071', --Советник
		'g000uu0072', --Архидьявол
		'g000uu8250', --Архидьявол
		'g000uu0073', --Баронесса
		'g000uu0074', --Вор
		'g000uu5302', --Вор
		'g000uu0096', --Рыцарь Смерти
		'g000uu0097', --Носферату
		'g000uu8252', --Носферату
		'g000uu0098', --Королева личей
		'g000uu8253', --Королева личей
		'g000uu0099', --Баньши
		'g000uu0100', --Вор
		'g000uu5303', --Вор
		'g000uu8251', --Дриада
		'g000uu8010', --Дриада
		'g000uu8009', --Вассал леса
		'g000uu8011', --Страж леса
		'g000uu8012', --Мудрец
		'g000uu8013', --Вор
		'g000uu5304', --Вор

		--- Фракционные герои-солдаты
		'g001uu0021', --Архимаг
		'g001uu0020', --Следопыт
		'g001uu0019', --Рыцарь на Пегасе
		'g001uu0022', --Архангел
		'g001uu0023', --Вор
		'g001uu0045', --Инженер
		'g001uu0044', --Королевский страж
		'g001uu0046', --Ученый
		'g070uu0003', --Ученый
		'g001uu0047', --Старейшина
		'g001uu0048', --Вор
		'g001uu0072', --Архидьявол
		'g070uu0004', --Архидьявол
		'g001uu0071', --Советник
		'g001uu0070', --Герцог
		'g001uu0073', --Баронесса
		'g001uu0074', --Вор
		'g001uu0098', --Королева личей
		'g070uu0001', --Носферату
		'g001uu0097', --Носферату
		'g001uu0096', --Рыцарь Смерти
		'g001uu0099', --Баньши
		'g001uu0100', --Вор
		'g001uu8010', --Дриада
		'g070uu0002', --Дриада
		'g001uu8009', --Вассал леса
		'g001uu8011', --Страж леса
		'g001uu8012', --Мудрец
		'g001uu8013', --Вор

		--- Фракционные призыватели-солдаты с большим кол-вом опыта
		'g000uu8185', -- Магистр стихий
		'g001uu7598', -- Теневидец
		'g001uu8242', -- Xозяин масок
		'g000uu0164', -- Повелитель волков

		--- Фракционные хиллеры-солдаты с большим кол-вом опыта
		'g000uu0017', -- Аббатиса
		'g000uu8035', -- Вильсида
		'g002uu8039', -- Вердант
		'g000uu7570', -- Епископ
		'g000uu7569', -- Иерей
		'g000uu8264', -- Иерарх
		'g000uu0151', -- Прорицательница
		'g000uu0013', -- Священник
		'g000uu8214', -- Дриолисса
		'g000uu8034', -- Солнечная Танцовщица
		'g000uu0150', -- Патриарх
		'g003uu8039', -- Древо жизни
		'g003uu8038', -- Энт целитель
		'g000uu8235', -- Сильфида
		'g000uu2002', -- Целитель
		'g003uu8037', -- Священное древо

		--- нейтральные лидеры с низкой неподкупностью 20%
		'g000uu5236', -- Гном
		'g000uu5117', -- Гоблин
		'g000uu5101', -- Крестьянин
		'g000uu8308', -- Молодой триббог
		'g000uu5130', -- Разбойник
		'g000uu7556', -- Гоблин-жгун
		'g000uu7533', -- Псина
		'g000uu7510', -- Птица рух лидер
		'g000uu7616', -- Гном упырь лидер
		'g000uu6004', -- Толстый бес л.
		'g000uu5201', -- Сквайр л.
		'g000uu7539', -- Колотун
		'g000uu7592', -- Торхот
		'g000uu7516', -- Энт Малый л.
		'g000uu5262', -- Сектант л.
		'g000uu7614', -- Искатель рун лидер
		'g000uu7553', -- Ведунья-лидер

		--- Все нейтральные хиллеры с большим кол-вом опыта (лидеры и солдаты)
		'g000uu8287', -- Св.дерево л.
		'g000uu8288', -- Энт целитель л.
		'g000uu7519', -- Вердант л.
		'g000uu8215', -- Дриолисса л.
		'g000uu8262', -- Знахарка л.
		'g000uu8289', -- Древо жизни л
		'g000uu7521', -- Целитель л.
		'g000uu5006', -- Великий Оракул
		--'g000uu8222', -- Волхв л. бафер
		--'g000uu8218', -- Волхв
		--'g000uu7544', -- Настоятельница
		'g000uu8213', -- Гоблин-шаман
		'g001uu8262', -- Знахарка
		'g000uu2021', -- Проповедник
		'g000uu6107', -- Темный эльф-жрец
		'g000uu7619', -- Слуга культа
		'g000uu8044', -- Темный Эльф Гаст л.

		------------- Bladerunner
		'g000uu8266', -- Дроттар--
		'g000uu8265', -- дева пламени--
		'g000uu1001', -- двойник
		--'g000uu8217', -- Призрачный дракон л.
		'g000uu8216', -- Призрачный дракон
		'g000uu8269', -- Кровавый дракон л.
		'g001uu8269', -- Кровавый дракон
		'g000uu5022', -- Черный дракон
		'g000uu5122', -- Черный дракон л.
		'g000uu8144', -- темный эльф гаст л.
		'g000uu2007', -- Мумификатор
		'g000uu2008', -- Длань Мортис

		------------- Водные лидеры
		'g000uu8230', -- Чудище
		'g000uu5127', -- Кракен
		'g000uu5129', -- Морской змей
		'g000uu7522', -- Наяда
		'g000uu8138', -- Никса
		'g000uu5126', -- Русалка
		'g000uu7536', -- Элементаль воды
		------------- Временно
		'g000uu8263', -- Чернокнижница
	},
	forbiddenItems = {

		-----------СТАНДАРТНЫЕ
		-- ОСНОВНЫЕ
		'g000ig6008', --Посох невидимости
		'g000ig6017', --Посох дневного света
		'g000ig6018', --Посох сумерек
		'g000ig5092', --Свиток "terra illudere"
		'g000ig0019', --Эликсир молниеносности
		'g000ig0020', --Эликсир могущества
		'g000ig0017', --Эликсир неуязвимости
		'g001ig0126', --Эликсир Всевышнего
		'g001ig0490', --Эликсир возвышения
		'g001ig0129', --Зелье вампиризма50
		'g001ig0020', --Великая аура вампиризма
		'g001ig0035', --Великая аура жизненной силы
		'g000ig5051', --Свиток "sanctuera"
		'g000ig5083', --Свиток "свет дня"
		'g000ig5095', --Свиток "сумерки"
		'g000ig8005', --Семимильные сапоги
		'g000ig9006', --Сфера окаменения
		'g000ig9039', --Сфера ужаса
		'g001ig0596', --Линарет

		-- ПРЕДМЕТЫ НА УСКОР/РЕЗ МУВОВ
		'g000ig5032', --Свиток "Песнь скорости"
		'g000ig5053', --Свиток "Paraseus"
		'g000ig5094', --Свиток "Псалом Смерти"
		'g000ig6004', --Посох парализации
		'g000ig6005', --Посох путника
		'g001ig0390', --Посох терна
		'g001ig0389', --Посох первооткрывателя
		'g001ig0513', --Зелье твердого шага

		-- ЕЩЁ
		'g001ig0575', --Свиток "Подавляющая жизнь

		------------- Bladerunner
		'g001ig0414', --Отравленный вороний коготь (Артефакт)--
		'g000ig3015', --кристалл души (артефакт)--
		'g000ig3016', --рог инкуба (артефакт)--
		'g001ig0154', --знамя поглощения--
		'g001ig0158', --ужасающий топор (артефакт)--
		'g000ig3021', --кольцо колдуньи (артефакт)--
		'g001ig0023', --аура стремительности--
		'g001ig0017', --малая аура троля--
		'g000ig9007', --сфера забвения--
		'g000ig9040', --сфера ведьм--
		'g001ig0296', --сфера жестокости--
		'g000ig2007', --ржавые кандалы--
		'g001ig0275', --Кулон подстрекательства--
		'g000ig1011', --сапоги мореплавания
		'g001ig0044', --Сердце океана (Артефакт)

		--свитки на мувы
		'g000ig5027', --свиток мореплавания
		'g000ig5006', --Свиток "Ускорение"--
		'g000ig5100', --Свиток "Скорость"--
		'g000ig5113', --Свиток "Порыв"--
		'g000ig5099', --Свиток "Опутывание"--
		'g001ig0094', --Свиток "Поспешность" отступление
		'g000ig5120', --Свиток "Проворство" отступление

		--общее новое (имба)
		'g001ig0386', -- Посох семи ветров
		'g001ig0317', --Зелье дьявольских таинств +15 вампирик (пермо 600 дёшево)

		--доп
		'g000ig9125', --Талисман Лоупрау --т2 оборотни на всё поле (убрал из-за р-н т1 - дёшево 400)
		'g000ig9129', --Талисман Медвежьего Гнева (убрал из-за р-н т1)
		'g000ig9140', --Талисман лесной колдуньи (имба - превращение)

		--доп.новое
		'g000ig3008', --Обод мертвых (обидно ну)

		--свитки
		'g001ig0195', --Свиток "Откровение" (для аутрана не катит)
		'g001ig0439', --Свиток "Et seminibus discordiae - Уменьшает лидерство на 1 в области 5x5 (не для аутранера)
		'g001ig0440', --Свиток "Проклятие безволия минус лидерство
		'g001ig0092', --Свиток "Гниение леса" за 400 в ролле нафиг надо
		'g000ig5057', --Свиток "Мerum Facies" Защита от полиморфа за 700 в ролле нафиг надо
		'g000ig5118', --Свиток "Ослепления" Уменьшает обзор противника на 3 в радиусе 5х5.
		'g000ig5057', --Свиток "Мerum Facies" Защита от полиморфа.
		'g000ig5008', --Свиток "Призыв I: Живой доспех"
		'g000ig5025', --Свиток "Призыв I: Рух"
		'g000ig5061', --Свиток "Призыв I: Скелет"
		'g000ig5098', --Свиток "Призыв I: Энт Малый"
		'g000ig5031', --Свиток "Призыв II: Валькирия"
		'g000ig5015', --Свиток "Призыв II: Голем"
		'g000ig5066', --Свиток "Призыв II: Хуорн"
		'g000ig5103', --Свиток "Призыв II: Энт"
		'g001ig0076', --Свиток "Призыв III: Каменная сущность"
		'g000ig5038', --Свиток "Призыв III: Каменный Предок"
		'g000ig5071', --Свиток "Призыв III: Кошмар"
		'g001ig0075', --Свиток "Призыв III: Ледяная сущность"
		'g001ig0074', --Свиток "Призыв III: Сущность бури"
		'g001ig0077', --Свиток "Призыв III: Сущность пламени"
		'g000ig5108', --Свиток "Призыв III: Энт Большой"
		'g000ig5117', --Свиток "Призыв IV: Вердант"
		'g001ig0078', --Свиток "Призыв IV: Стихийный голем"
		'g000ig5078', --Свиток "Призыв IV: Танатос"
		'g001ig0080', --Свиток "Призыв V: Вестник немощи"
		'g001ig0081', --Свиток "Призыв V: Вестник перемен"
		'g001ig0079', --Свиток "Призыв V: Вестник поглощения"
		--на урон т4+
		'g000ig5090', --Potentia Ignis
		'g000ig5056', --Sinestra ignis
		'g000ig5086', --Духи льда
		'g000ig5112', --Лавина
		'g000ig5077', --Огненное дыхание
		'g000ig5093', --Смерч Смерти
		'g000ig5105', --Утопление
		'g000ig5081', --Цепь молний
		'g000ig5060', --Deus talonis
		'g000ig5019', --Армагеддон
		'g000ig5080', --Истребление

		--предметы на опыт
		'g001ig0587', -- Знамя мастера
		'g001ig0588', -- Знамя тысячи битв
		'g001ig0523', -- Зелье воеводы

		--
		'g002ig0021', -- Знамя двойственной судьбы

		--пермо
		'g001ig0519', -- Война престолов(+10 сопротивления ворам)
		'g001ig0525', -- Эликсир учености (артефакты)
		'g001ig0526', -- Зелье оруженосца (знаменосец)
		'g001ig0527', -- Зелье постижения (тайное знание)
		'g001ig0528', -- Честный труд (походное снаряжение)
		'g001ig0529', -- Каталог магических сфер (сферы)
		'g001ig0530', -- Зелье посмертного зовы(талисманы)
		'g001ig0531', -- Зелье слова(свитки)

		--
		'g001ig0610', -- Оковы долга (Реликвия)
		'g001ig0539', -- Тисовый лук (Реликвия)
	},

	getContents = getTemplateContents
}
------------------------------------------------------------------------------------------------------------------------
--- The End
------------------------------------------------------------------------------------------------------------------------
