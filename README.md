# O golpe tá aí, cai quem quer! — V3

Aplicativo educacional gamificado sobre phishing, engenharia social e segurança digital.

## Funciona imediatamente
Abra `index.html` em um servidor web. Sem configuração, o aplicativo funciona em **modo local** com perfis, XP, badges e ranking no dispositivo.

## Ativar nuvem, login Google e ranking global (Supabase)
1. Crie um projeto gratuito no Supabase.
2. No SQL Editor, execute `supabase.sql`.
3. Em Authentication > Providers, habilite Google e configure as credenciais OAuth fornecidas pelo Google Cloud.
4. Em Authentication > URL Configuration, adicione a URL pública do aplicativo em Redirect URLs.
5. Copie Project URL e anon/public key para `config.js`.
6. Publique todos os arquivos juntos em HTTPS (GitHub Pages, Netlify etc.).

Não coloque `service_role` key no navegador. Use apenas a chave pública/anon.

## Arquivos
- `index.html`: aplicação
- `config.js`: configuração pública do Supabase
- `supabase.sql`: banco, políticas RLS e criação automática de perfil
- `manifest.webmanifest`: instalação PWA
- `sw.js`: cache/offline
- `icon.svg`: ícone

## Privacidade
O modo local não exige e-mail. No modo Google, o provedor autentica o usuário; o ranking público usa apenas o apelido, XP e badges.
