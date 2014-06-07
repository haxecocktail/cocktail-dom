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
 * User agents must create a DOMImplementation object whenever a document 
 * is created and associate it with that document.
 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#domimplementation
 */
class DOMImplementation {

	public function new() { }

	/**
	 * [NewObject]
	 */
	public function createDocumentType(qualifiedName : String, publicId : String, systemId : String) : DocumentType {

		// TODO 1 - If qualifiedName does not match the Name production, throw an "InvalidCharacterError" exception.

		// TODO 2 - If qualifiedName does not match the QName production, throw a "NamespaceError" exception.

		// TODO 3 - Return a new doctype, with qualifiedName as its name, publicId as its public ID, and systemId as its system ID, and with its node document set to the associated document of the context object.
	#if strict
        throw "Not implemented!";
    #end
	}
	/**
	 * [NewObject]
	 */
	public function createDocument(? namespace : Null<String>, ? qualifiedName : String = "", ? doctype : Null<DocumentType>) : XMLDocument {

	#if strict
        throw "Not implemented!";
    #end
	}
	/**
	 * [NewObject]
	 */
	public function createHTMLDocument(? title : Null<String>) : Document {

		// TODO http://www.w3.org/TR/2014/CR-dom-20140508/#dom-domimplementation-createhtmldocument
	#if strict
        throw "Not implemented!";
    #end
	}

	/**
	 * useless; always returns true
	 */
	public function hasFeature() : Bool {

		return true;
	}
}