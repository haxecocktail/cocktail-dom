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
 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#interface-comment
 */
class Comment extends CharacterData {        

    public function new(? data : String = "") {

        super();

        this.data = data;
    }

    ///
    // GETTER / SETTER
    //

    override private function get_nodeType() : Int {

        return Node.COMMENT_NODE;
    }
    override private function get_nodeName() : String {

        return DOMConstants.COMMENT_NODE_NAME;
    }

    ///
    // INTERNALS
    //

    override private function doCloneNode() : Node {

        var clone : Comment = new Comment(this.data);

        return clone;
    }
}
