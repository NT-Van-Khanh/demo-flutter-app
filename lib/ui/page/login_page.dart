import 'package:b1_first_flutter_app/l10n/app_localizations.dart';
import 'package:b1_first_flutter_app/provider/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: library_private_types_in_public_api
final GlobalKey<_LoginSmallLayoutState> loginKey = GlobalKey();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _alignmentAnimation;

  @override
    void initState() {
      super.initState();

      _controller = AnimationController(
        duration: const Duration(seconds: 20),
        vsync: this,
      )..repeat(reverse: true);

      _alignmentAnimation = Tween<Alignment>(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedBuilder(
          animation: _alignmentAnimation,
          builder: (context, child) {
          return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin:  _alignmentAnimation.value,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromARGB(255, 157, 211, 255), 
                      Color.fromRGBO(214, 153, 21, 1),
                      Color.fromARGB(255, 10, 105, 213),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if(constraints.maxWidth<= 450){
                          return LoginSmallLayout(key: loginKey);
                        }else{
                          return LoginMediumLayout();
                        }
                  },
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

class LoginMediumLayout extends StatelessWidget {
  const LoginMediumLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 450, // giới hạn bề ngang tối đa
        ),
        child: Container(
          width: 450,
          height: 600,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white24,
                  blurRadius: 0,
                  spreadRadius: 5,
                  offset: Offset(0, 8), // bóng đổ để "nổi lên"
                ),
              ],
            borderRadius: BorderRadius.circular(30),
          ),
          child: LoginSmallLayout(key: loginKey),
        ),
      ),
    );
  }
}

class LoginSmallLayout extends StatefulWidget {
  const LoginSmallLayout({
    super.key,
  });

  @override
  State<LoginSmallLayout> createState() => _LoginSmallLayoutState();
}

class _LoginSmallLayoutState extends State<LoginSmallLayout> {
    bool isHide = true;
    late IconData icon;
    final IconData iconHide = Icons.visibility_off;
    final IconData iconShow = Icons.visibility;
  
    late TextEditingController _usernameController;
    late TextEditingController _passwordController;
  
  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.notification),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    icon = iconHide; 
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var authState = context.watch<AuthProvider>();

    void hidePasswword(bool isHide){
      this.isHide = isHide;
      icon = isHide ? iconHide : iconShow;
    }

    void login() async{
      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();
      print("Username $username");
      print("Password $password");
       try {
          bool success = await authState.login(username, password);
          if (!mounted) return; 
          if (!success){
            _showMessage("Username hoặc password không đúng");
          }
        } catch (e) {
          _showMessage("Đăng nhập lỗi: $e");
        }
    }
  
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Flutter App",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize:32,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [    
              Text(
                AppLocalizations.of(context)!.username,
                  style: TextStyle(
                      fontSize:16,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600
                  ),
              ),
              TextField(
                autofocus: false,
                textAlign: TextAlign.end,
                 controller: _usernameController,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Icon(Icons.person),
                  ),
                  hintText: 'Enter your username',
                  hintStyle: TextStyle(
                    fontStyle: FontStyle.italic
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal:36.0),
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                  labelStyle: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600
                  ),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none)
                ),
                
              ),
            ],
          ),
          SizedBox(height: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [    
              Text(
                AppLocalizations.of(context)!.password,
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600
                  ),
              ),
              TextField(
                obscureText: isHide,
                autofocus: false,
                controller: _passwordController,
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Icon(Icons.lock_outline),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12.0, left: 6),
                    child: IconButton(
                      icon: Icon(icon),
                      onPressed: () {
                        setState(() =>  
                          hidePasswword(!isHide) 
                        );
                      },
                    ),
                  ),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                    fontStyle: FontStyle.italic
                  ),
                  contentPadding: const EdgeInsets.only(right: 0.0, left: 12),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                  labelStyle: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none)
                  ),
              ),
            ],
          ),
          SizedBox(height:50,),
          ElevatedButton(
            onPressed: login,   
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8),
              child: Text(
                AppLocalizations.of(context)!.login,
                style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600
                  ),
                ),
            ),
          ),
          SizedBox(height: 10,),
          Divider(
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          SizedBox(height: 30,),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.secondaryContainer,),
            ),
            onPressed: ()=>{}, 
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                 mainAxisSize: MainAxisSize.min, 
                children: [
                  Image.asset("assets/images/google.png",
                  width: 32,
                  height:32,),
                  Text(AppLocalizations.of(context)!.loginWithGoogle),
                ],
              ),
            )),
        ],
      ),
    );
  }
}
