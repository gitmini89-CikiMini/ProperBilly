# ProperBilly

ProperBilly to aplikacja do szacowania kosztów wynajmu nieruchomości. Jej celem jest umożliwienie właścicielom, zarządcom oraz najemcom oszacowania rzeczywistych kosztów, z uwzględnieniem czynszu, opłat eksploatacyjnych, mediów oraz innych kosztów stałych i zmiennych.

Aplikacja pozwala:
- dodawać różne typy nieruchomości (mieszkania, lokale użytkowe, miejsca parkingowe itd.),
- definiować najemców i powiązywać ich z nieruchomościami,
- tworzyć i kategoryzować opłaty (np. czynsz, woda, prąd, gaz, śmieci, internet, administracja),
- definiować modele naliczania (stałe, zmienne, odczyty liczników, stawki jednostkowe, ryczałty),
- konstruować z opłat sensowne, obliczalne pozycje (np. „Media – prąd” = stawka x zużycie + opłata stała),
- cyklicznie wprowadzać odczyty liczników (np. miesięczne) w celu oszacowania kosztów ponoszonych przez najemcę.

Uwaga: ProperBilly nie generuje faktur ani dokumentów księgowych — służy wyłącznie do estymacji kosztów.

## Główne założenia

- Elastyczny model opłat: każdą opłatę można zdefiniować jako:
  - stałą (kwota/miesiąc),
  - zmienną na podstawie wskazań liczników (zużycie x stawka),
  - mieszaną (opłata stała + część zmienna),
  - rozdzielaną pomiędzy najemców (np. proporcjonalnie do metrażu, liczby osób, udziałów).
- Wielość nieruchomości i najemców: możliwość zarządzania portfelem wielu nieruchomości oraz przypisywania najemców do jednostek.
- Historia i cykle rozliczeniowe: okresy (np. miesiąc/kwartał) z możliwością zapisu odczytów liczników i archiwizacji wyników kalkulacji.
- Przejrzyste kalkulacje: każda pozycja kosztowa powinna być wytłumaczalna (skąd się wzięła kwota), z możliwością wglądu w składniki.

## Przykładowe scenariusze użycia

1. Właściciel mieszkania chce oszacować miesięczny koszt dla najemcy:
   - Dodaje mieszkanie, przypisuje najemcę.
   - Definiuje opłaty: czynsz administracyjny (stały), prąd (stawka x zużycie), woda (stawka x zużycie), internet (stały).
   - Wprowadza co miesiąc wskazania liczników prądu i wody.
   - Otrzymuje zestawienie szacowanych kosztów za dany miesiąc.

2. Zarządca kilku lokali użytkowych:
   - Dodaje nieruchomości i najemców.
   - Dla opłat wspólnych (np. ogrzewanie) ustawia podział proporcjonalny do metrażu.
   - Rejestruje okresowe zużycie i generuje estymacje kosztów na lokal.

## Model danych (plan)

- Nieruchomość
  - nazwa, adres, typ (mieszkanie/lokal/parking/…)
  - metraż, dodatkowe parametry (opcjonalnie)
- Najemca
  - nazwa/imię i nazwisko, dane kontaktowe
- Umowa/Relacja najmu
  - powiązanie najemcy z nieruchomością
  - okres obowiązywania, notatki
- Opłata
  - nazwa, kategoria (czynsz/media/administracja/inne)
  - typ naliczania: stała, zmienna, mieszana
  - stawki jednostkowe (np. zł/kWh, zł/m3), opłaty stałe
  - reguła podziału (całość, proporcja metrażu, liczba osób, udział procentowy)
- Licznik
  - typ (prąd, woda, gaz), jednostka, przypisanie do nieruchomości
- Odczyt licznika
  - data, wartość, powiązanie z licznikiem
- Okres rozliczeniowy
  - zakres dat, wyliczone koszty, archiwizacja

## Plan funkcjonalny (MVP)

- Dodawanie/edycja/usuwanie:
  - nieruchomości,
  - najemców,
  - opłat (z typem naliczania),
  - liczników i ich odczytów.
- Kalkulacja miesięczna:
  - agregacja kosztów stałych,
  - wyliczenie kosztów zmiennych na podstawie zużycia w okresie,
  - zastosowanie reguł podziału.
- Podsumowanie:
  - zestawienie kosztów per najemca i per nieruchomość,
  - historia miesięcy i szybkie porównania.

## Przyszły rozwój

- Eksport zestawień (PDF/CSV).
- Szablony opłat (szybkie dodawanie typowych pakietów).
- Wiele walut i stawki VAT (tylko do celów informacyjnych).
- Notyfikacje o konieczności wprowadzenia odczytów.
- Synchronizacja danych w iCloud (opcjonalnie).
- Uprawnienia / role użytkowników (w przyszłości).
- Dodatkowa aplikacja dla najemcy, w celu samodzielnego odczytu liczników i przekazania ich przez chmurę do aplikacji właściciela (poprzez samodzielne wpisanie lub zdjęcie).

## Architektura i technologia

- Platforma docelowa: iOS/iPadOS (SwiftUI).
- Język: Swift.
- Architektura: MVVM
- Persystencja: planowane Core Data lub SwiftData (do potwierdzenia na etapie implementacji).
- Asynchroniczność: Swift Concurrency (async/await) tam, gdzie ma to sens (np. I/O).

## Status projektu

W fazie projektowania. Interfejs użytkownika i modele danych są w trakcie definiowania. Funkcje kalkulacyjne będą implementowane iteracyjnie, zaczynając od prostych stawek stałych i zmiennych opartych o odczyty liczników.

## Zgłaszanie uwag

Masz jakieś sugestie? Odezwij się do mnie.

## Zastrzeżenia

ProperBilly nie jest narzędziem księgowym ani fakturującym. Wyniki kalkulacji mają charakter szacunkowy i informacyjny.
