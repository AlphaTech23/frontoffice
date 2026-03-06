<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="com.example.frontoffice.model.Reservation"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.stream.Collectors"%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Réservations | Tableau de bord</title>
    
    <!-- Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- Animation CSS -->
    <style>
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .animate-fade-in {
            animation: fadeIn 0.5s ease-out forwards;
        }
        
        .stat-card:hover {
            transform: translateY(-4px);
            transition: transform 0.2s ease;
        }
        
        .table-row-hover:hover {
            background: linear-gradient(to right, #f9fafb, #ffffff);
        }
    </style>
</head>
<body class="bg-gray-50">
    <%
        List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
        String message = (String) request.getAttribute("message");
        LocalDate filterDate = (LocalDate) request.getAttribute("date");
        
        // Calcul des statistiques
        int totalReservations = reservations != null ? reservations.size() : 0;
        int totalPassagers = reservations != null ? 
            reservations.stream().mapToInt(Reservation::getNombrePassager).sum() : 0;
        long hotelsUniques = reservations != null ? 
            reservations.stream()
                .map(r -> r.getHotel() != null ? r.getHotel().getNom() : "Non spécifié")
                .distinct()
                .count() : 0;
        
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    %>

    <!-- Navigation -->
    <nav class="bg-white shadow-sm border-b border-gray-200 sticky top-0 z-10">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <div class="flex items-center space-x-4">
                    <div class="bg-gradient-to-r from-blue-600 to-indigo-600 text-white p-2 rounded-lg">
                        <i class="fas fa-calendar-check text-xl"></i>
                    </div>
                    <h1 class="text-xl font-semibold text-gray-800">Gestion des Réservations</h1>
                </div>
                <div class="text-sm text-gray-500">
                    <i class="far fa-clock mr-1"></i>
                    <%= LocalDateTime.now().format(dateTimeFormatter) %>
                </div>
            </div>
        </div>
    </nav>

    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Filtre -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6 mb-8 animate-fade-in">
            <form action="reservations" method="get" class="flex flex-col sm:flex-row items-end gap-4">
                <div class="flex-1 w-full">
                    <label class="block text-sm font-medium text-gray-700 mb-2">
                        <i class="fas fa-calendar-alt mr-2 text-blue-500"></i>
                        Filtrer par date
                    </label>
                    <div class="relative">
                        <input type="date" 
                               name="date" 
                               value="<%= filterDate != null ? filterDate : "" %>"
                               class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition">
                    </div>
                </div>
                <div class="flex gap-2 w-full sm:w-auto">
                    <button type="submit" 
                            class="flex-1 sm:flex-none bg-gradient-to-r from-blue-600 to-indigo-600 text-white px-6 py-2.5 rounded-lg hover:from-blue-700 hover:to-indigo-700 transition-all shadow-md hover:shadow-lg font-medium">
                        <i class="fas fa-search mr-2"></i>
                        Rechercher
                    </button>
                    <a href="reservations" 
                       class="flex-1 sm:flex-none bg-gray-100 text-gray-700 px-6 py-2.5 rounded-lg hover:bg-gray-200 transition-all font-medium text-center">
                        <i class="fas fa-times mr-2"></i>
                        Réinitialiser
                    </a>
                </div>
            </form>
        </div>

        <!-- Message d'erreur -->
        <% if(message != null && !message.isEmpty()) { %>
            <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-8 rounded-lg animate-fade-in">
                <div class="flex items-center">
                    <div class="flex-shrink-0">
                        <i class="fas fa-exclamation-circle text-red-500 text-xl"></i>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm text-red-700"><%= message %></p>
                    </div>
                </div>
            </div>
        <% } else { %>

        <!-- Statistiques -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="stat-card bg-white rounded-xl shadow-sm border border-gray-100 p-6 animate-fade-in" style="animation-delay: 0.1s">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Total réservations</p>
                        <p class="text-3xl font-bold text-gray-900 mt-2"><%= totalReservations %></p>
                    </div>
                    <div class="bg-blue-100 p-3 rounded-lg">
                        <i class="fas fa-ticket-alt text-blue-600 text-2xl"></i>
                    </div>
                </div>
            </div>
            
            <div class="stat-card bg-white rounded-xl shadow-sm border border-gray-100 p-6 animate-fade-in" style="animation-delay: 0.2s">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Total passagers</p>
                        <p class="text-3xl font-bold text-gray-900 mt-2"><%= totalPassagers %></p>
                    </div>
                    <div class="bg-green-100 p-3 rounded-lg">
                        <i class="fas fa-users text-green-600 text-2xl"></i>
                    </div>
                </div>
            </div>
            
            <div class="stat-card bg-white rounded-xl shadow-sm border border-gray-100 p-6 animate-fade-in" style="animation-delay: 0.3s">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Hôtels concernés</p>
                        <p class="text-3xl font-bold text-gray-900 mt-2"><%= hotelsUniques %></p>
                    </div>
                    <div class="bg-purple-100 p-3 rounded-lg">
                        <i class="fas fa-hotel text-purple-600 text-2xl"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tableau des réservations -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden animate-fade-in" style="animation-delay: 0.4s">
            <div class="px-6 py-4 border-b border-gray-100 bg-gray-50">
                <div class="flex items-center justify-between">
                    <h2 class="text-lg font-semibold text-gray-800">
                        <i class="fas fa-list mr-2 text-blue-500"></i>
                        Liste des réservations
                    </h2>
                    <% if(filterDate != null) { %>
                        <span class="bg-blue-100 text-blue-800 text-sm font-medium px-3 py-1 rounded-full">
                            <i class="far fa-calendar mr-1"></i>
                            <%= filterDate.format(dateFormatter) %>
                        </span>
                    <% } %>
                </div>
            </div>

            <% if(reservations != null && !reservations.isEmpty()) { %>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Client</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Passagers</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date d'arrivée</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Hôtel</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <% for(Reservation r : reservations) { 
                                String dateArriveeFormatted = r.getDateArrive() != null ? 
                                    r.getDateArrive().format(dateFormatter) : "Non spécifiée";
                                String hotelName = r.getHotel() != null ? 
                                    r.getHotel().getNom() : "Non spécifié";
                            %>
                                <tr class="table-row-hover transition-colors">
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="text-sm font-medium text-gray-900">#<%= r.getId() %></span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 h-8 w-8 bg-gradient-to-r from-blue-500 to-indigo-500 rounded-full flex items-center justify-center">
                                                <span class="text-white text-sm font-medium">
                                                    <%= r.getIdClient() != null ? r.getIdClient().substring(0, 1).toUpperCase() : "?" %>
                                                </span>
                                            </div>
                                            <div class="ml-3">
                                                <p class="text-sm font-medium text-gray-900">Client #<%= r.getIdClient() %></p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-2 py-1 text-xs font-medium <%= r.getNombrePassager() > 2 ? "bg-orange-100 text-orange-800" : "bg-green-100 text-green-800" %> rounded-full">
                                            <i class="fas fa-user mr-1"></i>
                                            <%= r.getNombrePassager() %> <%= r.getNombrePassager() > 1 ? "personnes" : "personne" %>
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center text-sm text-gray-900">
                                            <i class="far fa-calendar-alt text-gray-400 mr-2"></i>
                                            <%= dateArriveeFormatted %>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <i class="fas fa-building text-gray-400 mr-2"></i>
                                            <span class="text-sm text-gray-900"><%= hotelName %></span>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } else { %>
                <!-- État vide -->
                <div class="text-center py-16 px-6">
                    <div class="mb-4">
                        <i class="fas fa-folder-open text-gray-300 text-6xl"></i>
                    </div>
                    <h3 class="text-lg font-medium text-gray-900 mb-2">Aucune réservation trouvée</h3>
                    <p class="text-gray-500 mb-6">
                        <% if(filterDate != null) { %>
                            Aucune réservation pour le <%= filterDate.format(dateFormatter) %>
                        <% } else { %>
                            Aucune réservation n'est disponible pour le moment
                        <% } %>
                    </p>
                    <% if(filterDate != null) { %>
                        <a href="reservations" 
                           class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                            <i class="fas fa-times mr-2"></i>
                            Effacer le filtre
                        </a>
                    <% } %>
                </div>
            <% } %>
        </div>
        <% } %>
    </main>

    <!-- Footer -->
    <footer class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 mt-8">
        <p class="text-center text-sm text-gray-500">
            <i class="far fa-copyright mr-1"></i>
            <%= LocalDate.now().getYear() %> Gestion des Réservations. Tous droits réservés.
        </p>
    </footer>
</body>
</html>