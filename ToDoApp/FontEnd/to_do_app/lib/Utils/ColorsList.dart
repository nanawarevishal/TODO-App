

import 'package:flutter/material.dart';



class  Utils {

    static List<Color>colorList = const[
                        Color.fromRGBO(232, 237, 250, 1),
                        Color.fromRGBO(250, 232, 232, 1),
                        Color.fromRGBO(250, 249, 232, 1),
                        Color.fromRGBO(250, 232, 250, 1),
                        ];
    
    static List<Color>percentIndicatorList = [
                Colors.blue,
                Colors.orange,
                Colors.yellow,
                Colors.pink
    ];

    static List<String>imageUrl = ["assets/images/bag.png","assets/images/userIcon.png","assets/images/book.png"];

    static List<Color>imageBackGroundColor = [
        const Color.fromARGB(61, 253, 79, 137),
        const Color.fromARGB(83, 26, 52, 252),
        const Color.fromARGB(82, 252, 131, 26),
        const Color.fromARGB(82, 252, 207, 26),
    ];

    static List<List<Color>>taskGroupPrecentColors =[
        [
            const Color.fromARGB(84, 233, 30, 98),
            const Color.fromARGB(255, 255, 90, 145)
        ],
        [
            const Color.fromARGB(83, 26, 52, 252),
            const Color.fromARGB(255, 123, 90, 255)
        ],
        [
            const Color.fromARGB(82, 252, 131, 26),
            const Color.fromARGB(255, 255, 137, 90)
        ],
        [
            const Color.fromARGB(82, 252, 207, 26),
            const Color.fromARGB(255, 255, 189, 90)
        ]
    ];

    static List<String>status = ["done","In Progress", "To do"];

    static List<List<Color>>statusColor = [
        [
            const Color.fromARGB(83, 26, 52, 252),
            const Color.fromARGB(255, 123, 90, 255)
        ],

        [
            const Color.fromARGB(82, 252, 131, 26),
            const Color.fromARGB(255, 255, 137, 90)
        ],

        [
            const Color.fromARGB(84, 28, 196, 252),
            const Color.fromARGB(255, 90, 211, 255)
        ],


    ];

}

