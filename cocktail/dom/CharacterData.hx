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
 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#interface-characterdata
 * Note: CharacterData is an abstract interface and does not exist as node. 
 * It is used by Text, Comment, and ProcessingInstruction nodes.
 */
class CharacterData extends Node {

    /**
     * [TreatNullAs=EmptyString]
     */
    public var data (default, set) : String = "";

    /**
     * readonly
     */
    public var length (default, never) : Int;
    /**
     * readonly
     */
    public var previousElementSibling (get, null) : Null<Element>;
    /**
     * readonly
     */
    public var nextElementSibling (get, null) : Null<Element>;

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

    public function substringData(offset : Int, count : Int) : String {

        return DOMTools.substringData(this, offset, count);
    }

    public function appendData(data : String) : Void {

        DOMTools.replaceData(this, length, 0, data);
    }

    public function insertData(offset : Int, data : String) : Void {

        DOMTools.replaceData(this, offset, 0, data);
    }

    public function deleteData(offset : Int, count : Int) : Void {

        DOMTools.replaceData(this, offset, count, "");
    }

    public function replaceData(offset : Int, count : Int, data : String) : Void {

        DOMTools.replaceData(this, offset, count, data);
    }

    ///
    // GETTER / SETTER
    //

    private function get_previousElementSibling() : Null<Element> {

        return DOMTools.previousElementSibling(this);
    }
    private function get_nextElementSibling() : Null<Element> {

        return DOMTools.nextElementSibling(this);
    }
    override private function get_nodeValue() : Null<String> {

        return data;
    }
    override private function set_nodeValue(value : Null<String>) : Null<String> {

        DOMTools.replaceData(this, 0, length, value != null ? value : "");

        return data;
    }
    override private function get_textContent() : Null<String> {

        return data;
    }
    override private function set_textContent(value : Null<String>) : Null<String> {

        DOMTools.replaceData(this, 0, length, value != null ? value : "");

        return data;
    }
    private function set_data(v : String) : String {

        if (v == null) v = "";

        data = v;

        return data;
    }

    private function get_length() : Int {

        return data.length;
    }
}
