/**
 * Cocktail DOM Implementation
 * @see https://github.com/haxecocktail/cocktail-dom
 * 
 * Cocktail, HTML rendering engine
 * @see http://haxe.org/com/libs/cocktail
 *
 * Copyright (c) Silex Labs 2013 - 2014
 * Cocktail is available under the MIT license
 * @see http://www.silexlabs.org/labs/cocktail-licensing/
 */
package cocktail.dom;

/**
 * TODO : for now NodeList is an array but it can
 * also be implemented using an abstract type which
 * enables operator overloading. This way it could
 * both be accessed as an array and have the 
 * standard item() method
 */
typedef NodeList = Array<Node>;
