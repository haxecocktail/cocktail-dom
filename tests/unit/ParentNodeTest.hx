package ;

import cocktail.dom.Attr;
import cocktail.dom.CharacterData;
import cocktail.dom.Comment;
import cocktail.dom.Document;
import cocktail.dom.DocumentFragment;
import cocktail.dom.DocumentType;
import cocktail.dom.DOMConstants;
import cocktail.dom.DOMException;
import cocktail.dom.DOMImplementation;
import cocktail.dom.DOMSettableTokenList;
import cocktail.dom.DOMTokenList;
import cocktail.dom.DOMTools;
import cocktail.dom.Element;
import cocktail.dom.HTMLCollection;
import cocktail.dom.Node;
import cocktail.dom.NodeList;
import cocktail.dom.ProcessingInstruction;
import cocktail.dom.Text;

import massive.munit.Assert;

class ParentNodeTest
{
    public function new() { }

    @Before
    public function setup():Void
    {
    	this.document = new Document();

    	this.elt = document.createElement("a");
    	elt.id = "elt1";
    	elt.className = "testElt";

    	this.elt2 = document.createElement("b");
    	this.elt3 = document.createElement("c");
    	elt3.className = "testElt2";
    	this.elt4 = document.createElement("d");
    	elt4.className = "testElt";
    	this.elt5 = document.createElement("d");
    	elt5.className = "testElt2";
        this.elt6 = document.createElement("e");
        this.elt7 = document.createElement("e");
    	this.elt8 = document.createElement("e");
        this.text1 = document.createTextNode("Test Cocktail Text Content");
        this.text2 = document.createTextNode("Test Cocktail Text Content 2");

    	document.appendChild(elt2);
    	elt2.appendChild(elt3);
        elt2.appendChild(elt4);
    	elt2.appendChild(text2);
    	elt4.appendChild(elt5);
        elt4.appendChild(elt6);
        elt4.appendChild(text1);
    	elt4.appendChild(elt7);
        elt5.appendChild(elt);
    	elt5.appendChild(elt8);
    }

    var document : Document;
    var elt : Element;
    var elt2 : Element;
    var elt3 : Element;
    var elt4 : Element;
    var elt5 : Element;
    var elt6 : Element;
    var elt7 : Element;
    var elt8 : Element;
    var text1 : Text;
    var text2 : Text;

    @Test
    public function testElementChildren()
    {
        Assert.isTrue(elt.children.length == 0);
        Assert.isTrue(elt.firstElementChild == null);
        Assert.isTrue(elt.lastElementChild == null);
        Assert.isTrue(elt.childElementCount == 0);

        Assert.isTrue(elt4.children.length == 3);
        Assert.isTrue(elt4.firstElementChild == elt5);
        Assert.isTrue(elt4.lastElementChild == elt7);
        Assert.isTrue(elt4.childElementCount == 3);

        elt7.remove();
        Assert.isTrue(elt4.lastElementChild == elt6);
        Assert.isTrue(elt4.childElementCount == 2);
    }

    @Test
    public function testQuerySelector()
    {
        Assert.isTrue(elt2.querySelector('d') == elt4);
        Assert.isTrue(elt2.querySelector('.testElt') == elt4);
        Assert.isNull(elt4.querySelector('b'));
        Assert.isTrue(elt2.querySelector('a') == elt);
    }

    @Test
    public function testQuerySelectorAll()
    {
        Assert.isTrue(elt2.querySelectorAll('d').length == 2);
        Assert.isTrue(elt2.querySelectorAll('e').length == 3);
        Assert.isTrue(elt2.querySelectorAll('c').length == 1);
        Assert.isTrue(elt6.querySelectorAll('a').length == 0);
    }

}