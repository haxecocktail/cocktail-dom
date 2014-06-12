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
 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#interface-documenttype
 */
class DocumentType extends Node {

	public function new(name : String, ? publicId : String = "", ? systemId : String = "") {

        super();

		this.name = name;
		this.publicId = publicId;
		this.systemId = systemId;
	}

	public var name (default, null) : String;
	public var publicId (default, null) : String;
	public var systemId (default, null) : String;

    public function before(/* (Node or DOMString)... nodes */) : Void {
    #if strict
        throw "Not implemented!";
    #end
    }
    public function after(/* (Node or DOMString)... nodes */) : Void {
    #if strict
        throw "Not implemented!";
    #end
    }
    public function replace(/* (Node or DOMString)... nodes */) : Void {
    #if strict
        throw "Not implemented!";
    #end
    }
    public function remove() : Void {

        if (parentNode != null) {

            DOMTools.remove(this, parentNode);
        }
    }

	///
	// GETTER / SETTER
	//

    override private function get_nodeType() : Int {

        return Node.DOCUMENT_TYPE_NODE;
    }
    override private function get_nodeName() : String {

        return name;
    }

    ///
    // INTERNALS
    //

    override private function doCloneNode() : Node {

        var clone : DocumentType = new DocumentType(this.name, this.publicId, this.systemId);

        return clone;
    }
}