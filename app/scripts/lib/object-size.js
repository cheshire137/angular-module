// This adds a size member to determine the length of an associative array!
// See: http://stackoverflow.com/a/6700/127280
Object.size = function(obj) {
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    }
    return size;
};