import 'package:gamers_brew/core/network/dio_client.dart';
import '../../../core/models/coffee_item.dart';
import 'package:flutter/material.dart';

class CoffeeRepository {
  final DioClient _client;

  CoffeeRepository(this._client);

  Future<List<CoffeeItem>> getCatalog([String? category = "Все"]) async {
    await Future.delayed(const Duration(milliseconds: 500));
    var menu = [
      CoffeeItem(
      id: "1",
      name: "Экспрессо First Blood",
      description: "Классический шот",
      price: 150,
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuBBcAGmbHYaGpUowjEz43_WZqPCWmqLUNarfTUrLL4l48TTAiGO18u-CgOUWZEpj-9LBcl0BItukicbimLnUz4LrrUhMrxSg2cI5oU6AzAi-IbEbbLO8eggAKnH-d1HcMCBv86G9xyqLfxJ-LVKd4Oy6BzBfFBfywc-BWxn2eBz5jLM-WPy7c61FG4ufhIms_O68csTCeJ6YhnUyER8_c1HBO0j9ySdO8fnv1fI3AJgSd1eOMP5RoIoSX1nOEbPvTnvNunbISRPtArn",
      category: "Кофе",
      ),
    CoffeeItem(
      id: "2",
      name: "Латте 'Mana Potion",
      description: "Нежный и сливочный",
      price: 250,
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuD60v1s3Ei15EmnpNAyZngDaLTr4bxdLE9Nx2zCP3TrH7I7ZJ2Drk9bJSanebk-Xs6BegRReucK0XBncfjtBDenOdJ4SortnoltPBzif7ssSOnMiGAMN90p-ovfzo__IebsDLGxgSWdabUEayp8KGf4pl9R2bQFdI7YXCkWI7HZRnk4IKxKjQJ3zV0x1-O4xP5XUMwr1c-FyP5wM6HYglE9aApUX8R3wLHT_63y57nThRcHVB9-1tIofH-b7uKAvUOTrTFYhIZSQWto",
      category: "Напитки",
      ),
    CoffeeItem(
      id: "3",
      name: "Health Potion",
      description: "Холодный чай с ягодами",
      price: 220,
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuCbuAD_QsG60j1TBfXU8hh-MogU7NkLuItKmPN1LpyL9P01CYRSAu8Gb3WYGBfRAAw9CkLFZzoMTTHR2GwW0Nsd0Z8g-KdrLgolLb1uph05G6RlJ2ii2u276ASWLeSifT7Pwe-Qb9yiaGWjkofWTmAESDY1gadyipLLJfI93D7DyLfm-VfsA_KubV5Yz_3nW4Ryo3uBSHoNX9wN3SF-KL2ZJL-L2mvchPRV2CeWZWDsvuJqYnXkybRHhuoP5P0AmHX2j0Gg-8pzvHTd",
      category: "Напитки",
      ),
    CoffeeItem(
      id: "4",
      name: "Капучино Respawn",
      description: "С пышной пенкой",
      price: 230,
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuCDTP5qcLIs8T2pi_KWgQGuo4TAv0W1eGvLDqoSE6iIO4o3Vpa3AP_usAirX-zZG8vvJi8svcvoQEAVmo1w5iafkB1vnGruMzqebAItXCsnfQ5cPL65QRgxRmQ383DwjhhqQeBXNub1pE0Eguof0p3Xj-Xl_Y_TnJqRfe4Gkgl8SZGhJoufM9U36r-zyLKAAei--Rb_CG31PKt4mLkwnCwDfD1jhQKJVeP07g3SJb59Uf9ufJEdPlbBC-zowOQ1ztjeNQUqADOs-ci9",
      category: "Напитки",
      ),
    ];

    return category == "Все" 
        ? menu 
        : menu.where((product) => product.category == category).toList(); 
  }

  Future<List<Image>> getCarouselImages() async {
    return [
      Image.network(
        "https://lh3.googleusercontent.com/aida-public/AB6AXuCDmNgdZowjyFugvY19LDSUpYK5_whu8B6AI8ux39zpayjE8XTVS0fZymiNrauGWyxusm7lDmP52gUYYinwVPDy-qPgk19ShG8Lwcq6VF5h5DbfrQvs8FkF7KLXSCo9R3mBIj2D-jMZJ9ewCkB1IF1l2yhzQGFRNjJsGfeWN79A4EMyMgy6v2UlylRLokq2DGctq-wA5DgqWF2HmlrSwKE72dvqVksHqWXw0voF1Jg-dmj4uMrVa8cXu2kcz_hEON02sZgL8sY7OV_x",
      ),
      Image.network(
        "https://lh3.googleusercontent.com/aida-public/AB6AXuAaXoHsnV2dmY2OCurhC-d7dz8Kjg6PJjqGDIY9VPjfvZsTz-RSDiC8kkOLdj612qkAB3BqyatickyWBZc0jVqbzRyBNKmLrcp4CN3UPKAUbxfc88jF1AZWuY5qVO5owoMz4E_ieICiCSl_8GbzMHuk_rtn9tHKvUs_ZWL2sGXJRsdfi-pkihVuETNibbBo-m42UOS-GlCVp9ynQKb-2SCrvxZ491Nj5fr74jfYqfQOGrvUH7_cQVvlUcG4eRm2BeuEj_V7oFjsiQb5",
      ),
    ];
  }

  Future<List<String>> getCategories() async {
    return ["Кофе", "Еда", "Напитки", "Акции"];
  }
}
