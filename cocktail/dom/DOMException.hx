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
 * DOM operations only raise exceptions in "exceptional" circumstances, i.e.,
 * when an operation is impossible to perform (either for logical reasons,
 * because data is lost, or because the implementation has become unstable).
 * In general, DOM methods return specific error values in ordinary
 * processing situations, such as out-of-bound errors 
 * when using NodeList.
 */
class DOMException 
{
    /**
     * The index is not in the allowed range.
     */
    static public inline var INDEX_SIZE_ERR : Int = 1;
    /**
     * historical
     */
    static public inline var DOMSTRING_SIZE_ERR : Int = 2;
    /**
     * The operation would yield an incorrect node tree.
     */
    static public inline var HIERARCHY_REQUEST_ERR : Int = 3;
    /**
     * The object is in the wrong document.
     */
    static public inline var WRONG_DOCUMENT_ERR : Int = 4;
    /**
     * The string contains invalid characters.
     */
    static public inline var INVALID_CHARACTER_ERR : Int = 5;
    /**
     * historical
     */
    static public inline var NO_DATA_ALLOWED_ERR : Int = 6;
    /**
     * The object can not be modified.
     */
    static public inline var NO_MODIFICATION_ALLOWED_ERR : Int = 7;
    /**
     * The object can not be found here.
     */
    static public inline var NOT_FOUND_ERR : Int = 8;
    /**
     * The operation is not supported.
     */
    static public inline var NOT_SUPPORTED_ERR : Int = 9;
    /**
     * historical
     */
    static public inline var INUSE_ATTRIBUTE_ERR : Int = 10;
    /**
     * The object is in an invalid state.
     */
    static public inline var INVALID_STATE_ERR : Int = 11;
    /**
     * The string did not match the expected pattern.
     */
    static public inline var SYNTAX_ERR : Int = 12;
    /**
     * The object can not be modified in this way.
     */
    static public inline var INVALID_MODIFICATION_ERR : Int = 13;
    /**
     * The operation is not allowed by Namespaces in XML. [XMLNS](http://www.w3.org/TR/dom/#refsXMLNS)
     */
    static public inline var NAMESPACE_ERR : Int = 14;
    /**
     * The object does not support the operation or argument.
     */
    static public inline var INVALID_ACCESS_ERR : Int = 15;
    /**
     * historical
     */
    static public inline var VALIDATION_ERR : Int = 16;
    /**
     * historical; use JavaScript's TypeError instead
     */
    static public inline var TYPE_MISMATCH_ERR : Int = 17;
    /**
     * The operation is insecure.
     */
    static public inline var SECURITY_ERR : Int = 18;
    /**
     * A network error occurred.
     */
    static public inline var NETWORK_ERR : Int = 19;
    /**
     * The operation was aborted.
     */
    static public inline var ABORT_ERR : Int = 20;
    /**
     * The given URL does not match another URL.
     */
    static public inline var URL_MISMATCH_ERR : Int = 21;
    /**
     * The quota has been exceeded.
     */
    static public inline var QUOTA_EXCEEDED_ERR : Int = 22;
    /**
     * The operation timed out.
     */
    static public inline var TIMEOUT_ERR : Int = 23;
    /**
     * The supplied node is incorrect or has an incorrect ancestor for this operation.  
     */
    static public inline var INVALID_NODE_TYPE_ERR : Int = 24;
    /**
     * The object can not be cloned.
     */
    static public inline var DATA_CLONE_ERR : Int = 25;

    public function new(code : Int) {

        this.code = code;
    }

    /**
     * The code exception field must return the value it was initialized to.
     */
    public var code (default, null) : Int;
}
