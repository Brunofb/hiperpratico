import 'package:hiperpratico/src/models/item_model.dart';
import 'package:hiperpratico/src/models/order_model.dart';
import 'package:hiperpratico/src/models/user_model.dart';

import '../models/cart_item_model.dart';

ItemModel gatorade = ItemModel(
  id: 'sblJ84DlNb',
  imgUrl: 'assets/products/7892840808013.jpg',
  itemName: 'Gatorade Frutas Cítricas Garrafa 500ML',
  price: 4.5,
  unit: 'un',
  description:'O Gatorade Frutas Cítricas é uma bebida isotônica indicada para repor os líquidos e sais minerais perdidos com o suor, tanto em atividade física quanto apenas pelo calor.',
);

ItemModel rexona = ItemModel(
  id: 'sblJ84DlNb',
  imgUrl: 'assets/products/7791293990569.jpg',
  itemName: 'Desodorante Rexona Aerosol Active Masculino 90G',
  price: 12.9,
  unit: 'un',
  description: 'Rexona Men Active Dry é um desodorante antitranspirante que oferece a você 72h de proteção contra a transpiração e o mau odor, em uma fórmula inovadora e livre de álcool etílico. Contém a exclusiva tecnologia MotionSense, na qual suas exclusivas microcápsulas são quebradas pelo atrito dos movimentos, liberando proteção extra ao longo do dia.',
);

ItemModel talento = ItemModel(
  id: 'sblJ84DlNb',
  imgUrl: 'assets/products/7891008230000.jpg',
  itemName: 'Talento Branco Crocante Garoto',
  price: 5.59,
  unit: 'un',
  description:'Açúcar, leite em pó integral, manteiga de cacau, lactose, cereais crocantes (farinha de milho enriquecida com ferro e ácido fólico, farinha de trigo integral, açúcar, aveia em flocos, farelo de trigo, coco ralado, água, extrato de malte, farinha de trigo enriquecida com ferro e ácido fólico, sal, cacau em pó e corante beta-caroteno), gordura vegetal, uva passa, emulsificantes lecitina de soja e poliglicerol poliricinoleato e aromatizante. contém glúten. alérgicos: contém leite, aveia E derivados de leite, de trigo, de cevada E de soja. pode conter amendoim, amêndoa, castanha-de-cajú, castanha-do-pará, centeio E avelã.',
);

ItemModel cerveja = ItemModel(
  id: 'sblJ84DlNb',
  imgUrl: 'assets/products/7891149010509.jpg',
  itemName: 'Cerveja Pilsen Brahma Chopp Lata 350ML',
  price: 2.5,
  unit: 'un',
  description:'É uma cerveja saborosa e balanceada, com o sabor autêntico de cerveja brasileira, com espuma cremosa e persistente, amargor presente e ligeiramente encorpada.',
);

ItemModel sabao = ItemModel(
  id: 'sblJ84DlNb',
  imgUrl: 'assets/products/7891150000100.jpg',
  itemName: 'Sabão Em Pó OMO Multiação Tanquinho 1KG',
  price: 12.9,
  unit: 'un',
  description:'O sabão em pó 67142495 Multiação da Omo contém 1kg e tem uma fórmula ideal para roupas brancas e coloridas e remove as manchas mais difíceis como óleo de cozinha, suco de laranja e sorvete de morango; tecido algodão. Com este sabão você terá roupas impecáveis e mais praticidade no dia a dia!',
);

ItemModel refri = ItemModel(
  id: 'sblJ84DlNb',
  imgUrl: 'assets/products/7892840127411.jpg',
  itemName: 'Refrigerante Guaraná Kuat Garrafa 500ML',
  price: 6.5,
  unit: 'un',
  description: 'Refrigerante de Guaraná Kuat Garrafa 600ml',
);

// Lista de produtos
List<ItemModel> items = [
  gatorade,
  rexona,
  talento,
  cerveja,
  sabao,
  refri,
];

List<String> categories = [
  'Ofertas',
  'Limpeza',
  'Cereais',
  'Hortifrutes',
  'Carnes',
  'Padaria',
  'Bebidas',
  'Bebês',
];

List<CartItemModel> cartItems = [
  CartItemModel(
    item: gatorade,
    quantity: 2,
  ),
  CartItemModel(
    item: rexona,
    quantity: 1,
  ),
  CartItemModel(
    item: cerveja,
    quantity: 3,
  ),
];

UserModel user = UserModel(
);

List<OrderModel> orders = [
  // Pedido 01
  OrderModel(
    copyAndPaste: 'q1w2e3r4t5y6',
    createdDateTime: DateTime.parse(
      '2023-06-08 10:00:10.458',
    ),
    overdueDateTime: DateTime.parse(
      '2023-06-08 11:00:10.458',
    ),
    id: 'asd6a54da6s2d1',
    status: 'pending_payment',
    total: 11.0,
    items: [
      CartItemModel(
        item: gatorade,
        quantity: 2,
      ),
      CartItemModel(
        item: cerveja,
        quantity: 2,
      ),
    ],
  ),

  // Pedido 02
  OrderModel(
    copyAndPaste: 'q1w2e3r4t5y6',
    createdDateTime: DateTime.parse(
      '2023-06-08 10:00:10.458',
    ),
    overdueDateTime: DateTime.parse(
      '2023-06-08 11:00:10.458',
    ),
    id: 'a65s4d6a2s1d6a5s',
    status: 'delivered',
    total: 11.5,
    items: [
      CartItemModel(
        item: sabao,
        quantity: 1,
      ),
    ],
  ),

  OrderModel(
    copyAndPaste: 'q1w2e3r4t5y6',
    createdDateTime: DateTime.parse(
      '2022-06-08 10:00:10.458',
    ),
    overdueDateTime: DateTime.parse(
      '2022-06-08 11:00:10.458',
    ),
    id: 'a65s4d6a2s1d6a5s',
    status: 'delivered',
    total: 11.5,
    items: [
      CartItemModel(
        item: rexona,
        quantity: 1,
      ),
    ],
  ),
];
