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
 * @see http://www.w3.org/TR/dom/#domimplementation
 */
class DOMImplementation {

	public function new(document : Document) {

		this.document = document;
	}

	private var document : Document;

	/**
	 * [NewObject]
	 */
	public function createDocumentType(qualifiedName : String, publicId : String, systemId : String) : DocumentType {

		// TODO 1 - If qualifiedName does not match the Name production, throw an "InvalidCharacterError" exception.

		// TODO 2 - If qualifiedName does not match the QName production, throw a "NamespaceError" exception.

		// TODO 3 - Return a new doctype, with qualifiedName as its name, publicId as its public ID, and systemId as 
		// its system ID, and with its node document set to the associated document of the context object.
		var d : DocumentType = new DocumentType(qualifiedName, publicId, systemId);

		DOMTools.adopt(d, document);

		return d;
	}
	/**
	 * [NewObject]
	 */
	public function createDocument(? namespace : Null<String>, ? qualifiedName : String = "", ? doctype : Null<DocumentType>) : Document {

	#if strict
        throw "Not implemented!";
    #end
    	return null;
	}
	/**
	 * [NewObject]
	 */
	public function createHTMLDocument(? title : Null<String>) : Document {

		// TODO http://www.w3.org/TR/dom/#dom-domimplementation-createhtmldocument
	#if strict
        throw "Not implemented!";
    #end
    	return null;
	}

	/**
	 * useless; always returns true
	 */
	public function hasFeature() : Bool {

		return true;
	}
}