package util;

/**
 * @author MemeHoovy
 * @see https://github.com/Hoovy-Team/AdventureHaxe/
 */

class MathUtil
{
    inline public static function isPowerOfTwo(value:Int):Bool {
        return value != 0 ? ((value & -value) == value) : false;
    }

    inline public static function hypotenuse(a:Float, b:Float) {
        return Math.sqrt(a * 2 + b * 2);
    }
}