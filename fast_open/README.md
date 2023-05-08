# Fast Open File

Это скрипт интерактивного поиска файлов по их содержимому.

Варианты использования:

1. Параметр `-n`: интерактивный поиск по содержимому среди всех файлов текущей
   директории. Нажатие `Enter` открывает файл в `nvim`:

   ```bash
   fast_open.sh -n
   ```

2. Параметр `-z`: поиск по содержимому среди моих конспектов, сделанных в Latex,
   после нажатия `Enter`, найденная строка открывается в виде pdf-файла в
   просмотрщике `zathura`:

   ```bash
   fast_open.sh -z
   ```

**Зависимости**:

- [ripgrep](https://github.com/BurntSushi/ripgrep);
- [fzf](https://github.com/junegunn/fzf);
- [fd-find](https://github.com/sharkdp/fd);
- [zathura](https://github.com/pwmt/zathura).
