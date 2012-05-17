get_name = function(text) {
	var name_pattern = /.+(?=\()/;
	match = text.match(name_pattern);
	return (match && match[0]) || text
}