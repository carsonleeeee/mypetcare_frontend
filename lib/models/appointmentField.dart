import 'package:flutter/material.dart';

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController timeController = TextEditingController();

TextEditingController userPhoneController = TextEditingController();
TextEditingController userEmailController = TextEditingController();
TextEditingController userPetController = TextEditingController();
TextEditingController userPetNameController = TextEditingController();

Container nameField = Container(
  width: 200.0,
  height: 25.0,
  child: new TextField(  
          controller: nameController,                                   
        )
);

Container emailField = Container(
  width: 200.0,
  height: 25.0,
  child: new TextField(  
          controller: emailController,                                   
        )
);

Container phoneField = Container(
  width: 200.0,
  height: 25.0,
  child: new TextField(  
          controller: phoneController,                                   
        )
);

Container dateField = Container(
  width: 200.0,
  height: 25.0,
  child: new TextField(  
          controller: dateController,                                   
        )
);

Container timeField = Container(
  width: 200.0,
  height: 25.0,
  child: new TextField(  
          controller: timeController,                                   
        )
);

Container userPhoneField = Container(            
  width: 280.0,            
  height: 50.0,
  child: TextField(      
    controller: userPhoneController,
    style: new TextStyle(fontSize: 18.0,color: Colors.teal),
    decoration: new InputDecoration(
          filled: true,
          fillColor: Colors.white,          
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white)),                  
          prefixIcon: const Icon(
            Icons.phone,color: Colors.teal                    
          ),        
          focusedBorder: InputBorder.none,          
        ),
  ),
);

Container userEmailField = Container(            
  width: 280.0,     
  height: 50.0,       
  child: TextField(      
    controller: userEmailController,
    style: new TextStyle(fontSize: 18.0,color: Colors.teal),
    decoration: new InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white)),                  
          prefixIcon: const Icon(
            Icons.email,color: Colors.teal                    
          ),        
          focusedBorder: InputBorder.none,          
        ),
  ),
);

Container userPetField = Container(            
  width: 280.0,    
  height: 50.0,        
  child: TextField(      
    controller: userPetController,
    style: new TextStyle(fontSize: 18.0,color: Colors.teal),
    decoration: new InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white)),                  
          prefixIcon: const Icon(
            Icons.pets,color: Colors.teal                    
          ),        
          focusedBorder: InputBorder.none,          
        ),
  ),
);

Container userPetNameField = Container(            
  width: 280.0,    
  height: 50.0,          
  child: TextField(      
    controller: userPetNameController,
    style: new TextStyle(fontSize: 18.0,color: Colors.teal),
    decoration: new InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white)),                  
          prefixIcon: const Icon(
            Icons.pets,color: Colors.teal                    
          ),        
          focusedBorder: InputBorder.none,          
        ),
  ),
);