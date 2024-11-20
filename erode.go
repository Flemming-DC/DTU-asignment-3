
for (x from 0 to 19) {
	for (y from 0 to 19) {
		// Processin border pixel
		if (x == 0)  { out_image(x,y) = 0; continue ; }
		if (y == 0)  { out_image(x,y) = 0; continue ; }
		if (x == 19) { out_image(x,y)= 0; continue ; }
		if (y == 19) { out_image(x,y)= 0; continue ; }
		// Processing inner pixel
		if ( in_image(x,y) == 0) {
			// Black pixel
			out_image(x,y) = 0;
		} else {
			// White pixel , cheking neighboring pixels
			if (in_image(x-1, y) == 0 or
				in_image(x+1, y) == 0 or
				in_image(x, y-1) == 0 or
				in_image(x, y+1) == 0) {
				// Erode
				out_image(x,y) = 0;
			} else {
				// Do not erode
				out_image(x,y) = 255;
			}
		}
	}
}

