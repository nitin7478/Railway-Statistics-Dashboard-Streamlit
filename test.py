import dash
# import dash_core_components as dcc
import pdfkit
from flask import Flask, make_response
from dash import dcc, html , Input , Output


app = dash.Dash()
server = app.server  # Flask server

# Define your Dash app layout
app.layout = html.Div([ 
        html.Div('Hello'),
        dbc.Button('CREAT PDF', id='run'),
        html.Div(id='hel'),
    # html.Div(id='pdf-download')
    ])

# @app.callback(
#     Output('pdf-download', 'children'),
#     Input('btn-download-pdf', 'n_clicks')
# )
# def download_pdf(n_clicks):
#     if n_clicks:
#         return None


app.clientside_callback(
        '''
        function (n_clicks) {
            if (n_clicks > 0) {
                var doc = new PDFDocument({layout:'landscape', margin: 25});
                var stream = doc.pipe(blobStream());
                
                doc.fontSize(28);
                doc.font('Helvetica-Bold');
                doc.text('Example'.toUpperCase(), 15, 40);
                doc.addPage().fontSize(28);
                doc.text('Showing that multiple pages work');
                doc.end();

                var saveData = (function () {
                    var a = document.createElement("a");
                    document.body.appendChild(a);
                    a.style = "display: none";
                    return function (blob, fileName) {
                        var url = window.URL.createObjectURL(blob);
                        a.href = url;
                        a.download = fileName;
                        a.click();
                        window.URL.revokeObjectURL(url);
                    };
                }());
                
                stream.on('finish', function() {
                
                  var blob = stream.toBlob('application/pdf');
                  saveData(blob, 'Report.pdf');
                
                    // iframe.src = stream.toBlobURL('application/pdf');
                });
            }
            return false;
        }
        ''',
        Output('hel', 'children'),
        [
            Input('run', 'n_clicks'),
        ]
    )

if __name__ == '__main__':
    app.run_server(debug=True)
