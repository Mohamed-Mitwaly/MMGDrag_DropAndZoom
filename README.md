MMGDrag-Drop
============

it is a simple library used for drag and drop any view like images for example..
you can get object from the library using --> +(MMGDrag_Drop*)getInstance;
you just send the view or images thay you want to be dragged using 
     --> -(int)arrayOfViewsToBeDraggedAndDrop:(NSArray*)viewsArray onView:(UIView*)mainView;
     //return --> 1 in case of success
     //       --> 0 in case of array = nil
     //       --> 2 in case of mainView = nil
