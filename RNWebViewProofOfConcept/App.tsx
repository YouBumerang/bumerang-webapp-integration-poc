import React from 'react';
import {
  Modal,
  SafeAreaView,
  ScrollView,
  StatusBar,
  Text,
  TouchableOpacity,
  View,
  useColorScheme,
  StyleSheet,
} from 'react-native';
import {WebView} from 'react-native-webview';
import {Colors} from 'react-native/Libraries/NewAppScreen';

const web = `
        <!DOCTYPE html>
        <html>
        <head>
            <style>
                /* Apply button styles */
                .apple-button {
                    width: 70vw;
                    height: 5vh;
                    border-radius: 8px;
                    display: inline-block;
                    padding: 10px 20px;
                    background-color: #000;
                    color: #fff;
                    border-radius: 5px;
                    border: none;
                    text-align: center;
                    text-decoration: none;
                    font-size: 40px;
                    cursor: pointer;
                    box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.25);
                    transition: background-color 0.3s ease;
                }
        
                h1 {
                    
                    font-size: 48px;
                }

                .apple-button:hover {
                    background-color: #222;
                }

                .apple-button:active {
                    background-color: #444;
                }

                /* Center button horizontally */
                body {
                    font-family: 'Arial', sans-serif;
                    font-weight: bold;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                }
            </style>
        </head>
        <body>
        <h1>Swift WebView Proof of Concept</h1>
        <button id="miBoton" class="apple-button">Enviar mensaje</button>
        <script>
            document.getElementById("miBoton").addEventListener("click", function() {
                window.ReactNativeWebView.postMessage("B-23948295 example Bumerang code");
            });
        </script>
        </body>
        </html>
`;

function App(): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';
  const [showWebView, setShowWebView] = React.useState(false);
  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor={backgroundStyle.backgroundColor}
      />
      <ScrollView contentContainerStyle={styles.scrollContainer}>
        <TouchableOpacity
          onPress={() => setShowWebView(true)}
          style={styles.buttonContainer}>
          <View style={styles.button}>
            <Text style={styles.buttonText}>Button</Text>
          </View>
        </TouchableOpacity>
        <Modal
          visible={showWebView}
          animationType="slide"
          transparent={true}
          onRequestClose={() => setShowWebView(false)}>
          <View style={styles.modalContainer}>
            <View style={styles.modalHeader}>
              <TouchableOpacity onPress={() => setShowWebView(false)}>
                <Text style={styles.closeButtonText}>Close</Text>
              </TouchableOpacity>
            </View>
            <WebView
              onMessage={event => {
                console.log(event.nativeEvent.data);
                setShowWebView(false);
              }}
              source={{
                html: web,
              }}
              style={styles.webView}
            />
          </View>
        </Modal>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
  },
  scrollContainer: {
    flexGrow: 1,
    justifyContent: 'center',
    alignItems: 'center',
    alignContent: 'center',
  },
  buttonContainer: {
    alignItems: 'center',
  },
  button: {
    backgroundColor: 'black',
    borderRadius: 10,
    paddingVertical: 12,
    paddingHorizontal: 24,
  },
  buttonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
  },
  modalContainer: {
    flex: 1,
    top: 50,
    justifyContent: 'center',
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'flex-end',
    padding: 10,
    backgroundColor: '#f5f5f5',
  },
  webView: {
    flex: 1,
    width: '100%',
    height: '100%',
  },
  closeButtonText: {
    color: 'blue',
  },
});

export default App;
