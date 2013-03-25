library incrementally_building;

import 'package:unittest/unittest.dart';

var data = [{'scheme': 'https', 'domain': 'news.ycombinator.com'}, 
            {'domain': 'www.google.com'}, 
            {'domain': 'reddit.com', 'path': 'search', 'params': 'q=dart'}
            ];

String assembleUrlsUsingStringBuffer(data) {
  StringBuffer sb = new StringBuffer();
  for (final item in data) {
    sb.write(item['scheme'] != null ? item['scheme']  : 'http');
    sb.write("://");
    sb.write(item['domain']);
    sb.write('/');
    sb.write(item['path'] != null ? item['path']  : '');
    if (item['params'] != null) {
      sb.write('?');
      sb.write(item['params']);
    }
    sb.write('\n');
  }
  return sb.toString();
}

String assembleUrlsUsingConcatenation(data) {
  var urls = '';
  for (final item in data) {
    urls += item['scheme'] != null ? item['scheme']  : 'http';
    urls += "://";
    urls += item['domain'];
    urls += '/';
    urls += item['path'] != null ? item['path']  : '';
    if (item['params'] != null) {
      urls += '?';
      urls += item['params'];
    }
    urls += '\n';
  }
  return urls;
}

void main() {
  group('incrementally building a string', () {
    group('using a StringBuffer', () {
      test('using write()', () {
        expect(assembleUrlsUsingStringBuffer(data), equals('''https://news.ycombinator.com/
http://www.google.com/
http://reddit.com/search?q=dart
'''));
    });
      test('using several methods', () {
        var sb = new StringBuffer();
        sb.writeln('The Beatles:');
        sb.writeAll(['John, ', 'Paul, ', 'George, and Ringo']);
        sb.writeCharCode(33); // charCode for '!'.
        expect(sb.toString(), equals('The Beatles:\nJohn, Paul, George, and Ringo!'));
      });
    });
    
    group('using concatenation', () {
      test('', () {  
        expect(assembleUrlsUsingConcatenation(data), equals('''https://news.ycombinator.com/
http://www.google.com/
http://reddit.com/search?q=dart
'''));
      });
    });
  });
}
