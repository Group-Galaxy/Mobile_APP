import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: Colors.transparent,
      elevation: 9.0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0)
          ),
          color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50.0,
             width: MediaQuery.of(context).size.width ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
          

                 ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  fixedSize: const Size(120, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2))),
            
                      onPressed: () {
  
                        
  
                      }, child:Text('Chat'), 
                  ),
                  
               
            
            
                   ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  fixedSize: const Size(120, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2))),
            
                      onPressed: () {
  
                        
  
                      },
  
                      child: Text('Order Now'),
                     
  
  
                  ),
                ],
              ),
            ),
          ],
        ),
      ),  
    );
  }
}