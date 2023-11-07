import 'package:flutter/material.dart';

class FoodUI extends StatefulWidget {
  const FoodUI({Key? key});

  @override
  State<FoodUI> createState() => _FoodUIState();
}

class _FoodUIState extends State<FoodUI> {
  int selectedItemIndex = -1;
  int selectedItemsCount = 0;

  void toggleCheckbox(int itemIndex, int index) {
    setState(() {
      isOrderedList[itemIndex][index] = !isOrderedList[itemIndex][index];
      // Update selectedItemsCount for the specific item
      if (isOrderedList[itemIndex][index]) {
        selectedItemsCount++;
      } else {
        selectedItemsCount--;
      }
    });
  }

  final List<String> imagePaths = [
    'assets/images/burger.png',
    'assets/images/fries.png',
    'assets/images/wings.png',
  ];
  final List<String> foodNames = [
    'Burger',
    'Fries',
    'Wings',
  ];
  List<List<bool>> isOrderedList = [
    [false, false, false],
    [false, false, false],
    [false, false, false],
  ];
  final List<List<String>> prices = [
    ['850/', '950/', '740/'],
    ['370/', '345/', '245/'],
    ['550/', '450/', '600/'],
  ];
  //List<bool> isOrderedList = List.generate(3, (index) => false);
  List<int> quantities = [0, 0, 0];

  void selectItem(int index) {
    setState(() {
      selectedItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Get your food',
                  style: TextStyle(
                      fontSize: 17, color: Color.fromARGB(255, 31, 28, 28))),
              const Text('Delivered!',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w900)),
              const Text('Catagories',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: height * 0.02,
              ),
              horizontalListView(height, width),
              SizedBox(
                height: height * 0.01,
              ),
              const Text('Flavors',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 31, 28, 28),
                  )),
              SizedBox(
                height: height * 0.01,
              ),
              if (selectedItemIndex != -1)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalListView(
                      height ,
                      width,
                    )
                  ],
                ),
              SizedBox(
                height: height * 0.07,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          '($selectedItemsCount)',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text(
                        'Items',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text(
                          'Add to Bill',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget horizontalListView(double height, double width){
      return SizedBox(
                height: height * 0.235,
                width: width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imagePaths.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        selectItem(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Container(
                          decoration: BoxDecoration(
                              color: selectedItemIndex == index
                                  ? Colors.red.shade300
                                  : Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(255, 96, 95, 95))
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: height * 0.1,
                                child: Image.asset(imagePaths[index]),
                              ),
                              Text(
                                foodNames[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: height * 0.1,
                                  width: width * 0.1,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedItemIndex == index
                                        ? Colors.white
                                        : Colors.red,
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        color: selectedItemIndex == index
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
  }
  Widget verticalListView(double height, double width) {
    return SizedBox(
      height: height * 0.4,
      width: width,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: prices[selectedItemIndex].length,
        itemBuilder: (context, index) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(17)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Checkbox(
                        activeColor: Colors.red,
                        onChanged: (value) {
                          toggleCheckbox(selectedItemIndex, index);
                        },
                        value: isOrderedList[selectedItemIndex][index],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.1,
                      width: width * 0.32,
                      child: Image.asset(imagePaths[selectedItemIndex]),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.01),
                      SizedBox(
                        width: width * 0.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              foodNames[selectedItemIndex],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(width: width * 0.25),
                            Container(
                              width: width * 0.06,
                              height: height * 0.03,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 149, 152, 149),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (quantities[index] > 0) {
                                        quantities[index]--;
                                      }
                                    });
                                  },
                                  child: const Icon(Icons.remove),
                                ),
                              ),
                            ),
                            Text(
                              quantities[index].toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Container(
                              width: width * 0.06,
                              height: height * 0.03,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      quantities[index]++;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            'RS.',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            prices[selectedItemIndex][index],
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.001),
                      Row(
                        children: [
                          const Text(
                            'Size',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(width: width * 0.16),
                          const Text(
                            'Other',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.01),
                      Row(
                        children: [
                          Container(
                            width: width * 0.2,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(221, 145, 143, 143),
                                width: 2.0,
                              ),
                            ),
                            child:  Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '2x',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          Container(
                            width: width * 0.4,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(221, 145, 143, 143),
                                width: 2.0,
                              ),
                            ),
                            child:  Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Extra Cheez Layer',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
